//
//  VehiclesViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 4.04.2023.
//

import UIKit

final class VehiclesViewController: UIViewController {

    @IBOutlet private weak var vehiclesTableView: UITableView!
    
    private var vehicles: [VehiclesResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Vehicles"
        
        vehiclesTableView.registerCell(cell: VehiclesTableViewCell.self)
        vehiclesTableView.delegate = self
        vehiclesTableView.dataSource = self
    
        Network.shared.request(endpointType: .vehicles, decodingTo: [VehiclesResponse].self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.vehicles.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.vehiclesTableView.reloadData()
                }
            case .failure(let error):
                print(CustomError(message: "Vehicles response error: \(error)"))
            }
        }
    }
}

extension VehiclesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = vehiclesTableView.dequeueReusableCell(withIdentifier: VehiclesTableViewCell.identifier, for: indexPath) as? VehiclesTableViewCell else { fatalError("VehiclesTableViewCell was not found") }
        cell.configure(with: vehicles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = vehicles[indexPath.row].url else { return }
        self.navigationController?.pushViewController(VehiclesDetailViewController(url: url), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndexPath = vehicles.count - 1
        guard lastIndexPath == indexPath.row else { return }
        guard !Network.shared.isPaginating else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.vehiclesTableView.tableFooterView = Network.shared.createSpinnerFooter(view: (self?.view)!)
        }
        
        Network.shared.request(endpointType: .vehicles, decodingTo: [VehiclesResponse].self) { [weak self] result in
            DispatchQueue.main.async {
                self?.vehiclesTableView.tableFooterView = nil
            }
            
            switch result {
            case .success(let response):
                self?.vehicles.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.vehiclesTableView.reloadData()
                }
                
            case .failure(let error):
                print(CustomError(message: "People response error: \(error)"))
            }
        }
    }
}
