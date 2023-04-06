//
//  SpeciesViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 3.04.2023.
//

import UIKit

final class SpeciesViewController: UIViewController {

    @IBOutlet private weak var speciesTableView: UITableView!
    
    private var species: [SpeciesResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Species"

        speciesTableView.registerCell(cell: SpeciesTableViewCell.self)
        speciesTableView.delegate = self
        speciesTableView.dataSource = self
        
        Network.shared.request(endpointType: .species, decodingTo: [SpeciesResponse].self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.species.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.speciesTableView.reloadData()
                }
            case .failure(let error):
                print(CustomError(message: "Species response error: \(error)"))
            }
        }
        
    }
    

}

extension SpeciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return species.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = speciesTableView.dequeueReusableCell(withIdentifier: SpeciesTableViewCell.identifier, for: indexPath) as? SpeciesTableViewCell else { fatalError("SpeciesTableViewCell was not found") }
        cell.configure(with: species[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = species[indexPath.row].url else { return }
        self.navigationController?.pushViewController(SpeciesDetailViewController(url: url), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndexPath = species.count - 1
        guard lastIndexPath == indexPath.row else { return }
        guard !Network.shared.isPaginating else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.speciesTableView.tableFooterView = Network.shared.createSpinnerFooter(view: (self?.view)!)
        }
        
        Network.shared.request(endpointType: .species, decodingTo: [SpeciesResponse].self) { [weak self] result in
            DispatchQueue.main.async {
                self?.speciesTableView.tableFooterView = nil
            }
            
            switch result {
            case .success(let response):
                self?.species.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.speciesTableView.reloadData()
                }
                
            case .failure(let error):
                print(CustomError(message: "People response error: \(error)"))
            }
        }
    }
}
