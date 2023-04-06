//
//  PeopleViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 28.03.2023.
//

import UIKit

final class PeopleViewController: UIViewController {
    @IBOutlet private weak var peopleTableView: UITableView!
    
    private var people: [PeopleResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        peopleTableView.registerCell(cell: PeopleTableViewCell.self)
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        
        Network.shared.request(endpointType: .people, decodingTo: [PeopleResponse].self) {[weak self] result in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = people[indexPath.row].url else { return }
        self.navigationController?.pushViewController(PeopleDetailViewController(url: url), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndexPath = people.count - 1
        guard lastIndexPath == indexPath.row else { return }
        guard !Network.shared.isPaginating else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.peopleTableView.tableFooterView = Network.shared.createSpinnerFooter(view: (self?.view)!)
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
