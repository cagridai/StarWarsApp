//
//  VehiclesDetailViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 5.04.2023.
//

import UIKit

final class VehiclesDetailViewController: UIViewController {
    
    @IBOutlet private weak var vehiclesName: UILabel!
    @IBOutlet private weak var vehiclesModel: UILabel!
    @IBOutlet private weak var manufacturer: UILabel!
    @IBOutlet private weak var costInCredits: UILabel!
    @IBOutlet private weak var length: UILabel!
    @IBOutlet private weak var maxAtmospheringSpeed: UILabel!
    @IBOutlet private weak var crew: UILabel!
    @IBOutlet private weak var passengers: UILabel!
    @IBOutlet private weak var cargoCapacity: UILabel!
    @IBOutlet private weak var consumables: UILabel!
    @IBOutlet private weak var vehicleClass: UILabel!
    
    private let url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Network.shared.detailRequest(endpointType: .vehiclesDetail(url: url), decodingTo: VehiclesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.vehiclesName.text = response.name
                    self?.vehiclesModel.text = "Model: \(response.model ?? "unknown")"
                    self?.manufacturer.text = "Manufacturer: \(response.manufacturer ?? "unknown")"
                    self?.costInCredits.text = "Cost in credits: \(response.costInCredits ?? "unknown")"
                    self?.length.text = "Length: \(response.length ?? "unknown")"
                    self?.maxAtmospheringSpeed.text = "Max atmosphering speed: \(response.maxAtmospheringSpeed ?? "unknown")"
                    self?.crew.text = "Crew size: \(response.crew ?? "unknown")"
                    self?.passengers.text = "Passengers size: \(response.passengers ?? "unknown")"
                    self?.cargoCapacity.text = "Cargo capacity: \(response.cargoCapacity ?? "unknown")"
                    self?.consumables.text = "Consumables: \(response.consumables ?? "unknown")"
                    self?.vehicleClass.text = "Vehicle class: \(response.vehicleClass ?? "unknown")"
                }
            case .failure(let error):
                print("Starships Detail error: \(error.localizedDescription)")
            }
        }
        
    }
}
