//
//  PeopleViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 28.03.2023.
//

import UIKit

//protocol PeopleViewControllerDelegate: AnyObject {
//    func didTapMenuButton()
//}

final class PeopleViewController: UIViewController {
    @IBOutlet weak var peopleTableView: UITableView!
    
//    weak var delegate: PeopleViewControllerDelegate?
    
    private var people: [PeopleResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.star"), style: .done, target: self, action: #selector(didTapMenuButton))
        
        peopleTableView.registerCell(cell: PeopleTableViewCell.self)
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        
    }

//    @objc private func didTapMenuButton() {
//        delegate?.didTapMenuButton()
//    }


}

extension PeopleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = peopleTableView.dequeueReusableCell(withIdentifier: PeopleTableViewCell.identifier, for: indexPath) as? PeopleTableViewCell else { fatalError("PeopleTableViewCell was not found")}
        cell.configurePeopleCell(with: people[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension PeopleViewController: UIScrollViewDelegate {
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (peopleTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            guard !Network.shared.isPaginating else { return }
            
            DispatchQueue.main.async {
                self.peopleTableView.tableFooterView = self.createSpinnerFooter()
            }
            
            Network.shared.request(endpointType: .people, decodingTo: [PeopleResponse].self) { [weak self] result in
                DispatchQueue.main.async {
                    self?.peopleTableView.tableFooterView = nil
                }
                
                switch result {
                case .success(let response):
                    self?.people.append(contentsOf: response)
                    DispatchQueue.main.async {
                        self?.peopleTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(CustomError(message: "People response error: \(error)"))
                }
            }
        }
    }
}
    
