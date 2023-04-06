//
//  StarshipsViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 4.04.2023.
//

import UIKit

final class StarshipsViewController: UIViewController {

    @IBOutlet private weak var starshipsTableView: UITableView!
    
    private var starships: [StarshipsResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Starships"
        
        starshipsTableView.registerCell(cell: StarshipsTableViewCell.self)
        starshipsTableView.delegate = self
        starshipsTableView.dataSource = self
        
        Network.shared.request(endpointType: .starships, decodingTo: [StarshipsResponse].self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.starships.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.starshipsTableView.reloadData()
                }
            case .failure(let error):
                print(CustomError(message: "Starships response error: \(error)"))
            }
        }
    }
}

extension StarshipsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = starshipsTableView.dequeueReusableCell(withIdentifier: StarshipsTableViewCell.identifier, for: indexPath) as? StarshipsTableViewCell else { fatalError("StarshipsTableViewCell was not found") }
        cell.configure(with: starships[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = starships[indexPath.row].url else { return }
        self.navigationController?.pushViewController(StarshipsDetailViewController(url: url), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndexPath = starships.count - 1
        guard lastIndexPath == indexPath.row else { return }
        guard !Network.shared.isPaginating else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.starshipsTableView.tableFooterView = Network.shared.createSpinnerFooter(view: (self?.view)!)
        }
        
        Network.shared.request(endpointType: .starships, decodingTo: [StarshipsResponse].self) { [weak self] result in
            DispatchQueue.main.async {
                self?.starshipsTableView.tableFooterView = nil
            }
            
            switch result {
            case .success(let response):
                self?.starships.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.starshipsTableView.reloadData()
                }
                
            case .failure(let error):
                print(CustomError(message: "Starships response error: \(error)"))
            }
        }
    }
}
