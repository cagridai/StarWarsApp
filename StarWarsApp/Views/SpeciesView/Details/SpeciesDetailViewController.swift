//
//  SpeciesDetailViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 5.04.2023.
//

import UIKit

final class SpeciesDetailViewController: UIViewController {
    @IBOutlet private weak var speciesName: UILabel!
    @IBOutlet private weak var classification: UILabel!
    @IBOutlet private weak var designation: UILabel!
    @IBOutlet private weak var avarageHeight: UILabel!
    @IBOutlet private weak var skinColors: UILabel!
    @IBOutlet private weak var hairColors: UILabel!
    @IBOutlet private weak var eyeColors: UILabel!
    @IBOutlet private weak var averageLifespan: UILabel!
    @IBOutlet private weak var language: UILabel!
    
    private var url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Network.shared.detailRequest(endpointType: .speciesDeitail(url: url), decodingTo: SpeciesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.speciesName.text = response.name
                    self?.classification.text = "Classification: \(response.classification ?? "unknown")"
                    self?.designation.text = "Designation: \(response.designation ?? "unknown")"
                    self?.avarageHeight.text = "Average height: \(response.averageHeight ?? "unknown")"
                    self?.skinColors.text = "Skin colors: \(response.skinColors ?? "unknown")"
                    self?.hairColors.text = "Hair colors: \(response.hairColors ?? "unknown")"
                    self?.eyeColors.text = "Eye colors: \(response.eyeColors ?? "unknown")"
                    self?.averageLifespan.text = "Average lifspan: \(response.averageLifespan ?? "unknown")"
                    self?.language.text = "Language: \(response.language ?? "unknown")"
                }
            case .failure(let error):
                print("Species Detail error: \(error.localizedDescription)")
            }
        }
        
    }
}
