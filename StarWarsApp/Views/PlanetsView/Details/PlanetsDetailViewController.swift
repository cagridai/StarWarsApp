//
//  PlanetsDetailViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 5.04.2023.
//

import UIKit

final class PlanetsDetailViewController: UIViewController {
    @IBOutlet private weak var planetName: UILabel!
    @IBOutlet private weak var rotationPeriod: UILabel!
    @IBOutlet private weak var orbitalPeriod: UILabel!
    @IBOutlet private weak var diameter: UILabel!
    @IBOutlet private weak var climate: UILabel!
    @IBOutlet private weak var graivty: UILabel!
    @IBOutlet private weak var terrain: UILabel!
    @IBOutlet private weak var population: UILabel!
    
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

        Network.shared.detailRequest(endpointType: .planetsDetail(url: url), decodingTo: PlanetResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.planetName.text = response.name
                    self?.rotationPeriod.text = "Rotation Period: \(response.rotationPeriod ?? "unknown")"
                    self?.orbitalPeriod.text = "Orbital Period: \(response.orbitalPeriod ?? "unknown")"
                    self?.diameter.text = "Diameter: \(response.diameter ?? "unknown")"
                    self?.climate.text = "Climate: \(response.climate ?? "unknown")"
                    self?.graivty.text = "Gravity: \(response.gravity ?? "unknown")"
                    self?.terrain.text = "Terrain: \(response.terrain ?? "unknown")"
                    self?.population.text = "Population: \(response.population ?? "unknown")"
                }
            case .failure(let error):
                print("Planets Detail error: \(error.localizedDescription)")
            }
        }
        
        
    }
}
