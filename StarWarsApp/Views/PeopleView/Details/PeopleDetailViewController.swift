//
//  PeopleDetailViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 5.04.2023.
//

import UIKit

final class PeopleDetailViewController: UIViewController {
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var height: UILabel!
    @IBOutlet private weak var mass: UILabel!
    @IBOutlet private weak var hairColor: UILabel!
    @IBOutlet private weak var skinColor: UILabel!
    @IBOutlet private weak var eyeColor: UILabel!
    @IBOutlet private weak var birthYear: UILabel!
    @IBOutlet private weak var gender: UILabel!
    
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

        Network.shared.detailRequest(endpointType: .peopleDetail(url: url), decodingTo: PeopleResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.name.text = response.name
                    self?.height.text = "Height: \(response.height ?? "unknwon")"
                    self?.mass.text = "Weight: \(response.mass ?? "unknwon")"
                    self?.hairColor.text = "Hair Color: \(response.hairColor ?? "unknwon")"
                    self?.skinColor.text = "Skin Color: \(response.skinColor ?? "unknwon")"
                    self?.eyeColor.text = "Eye Color: \(response.eyeColor ?? "unknwon")"
                    self?.birthYear.text = "Birth Year: \(response.birthYear ?? "unknwon")"
                    self?.gender.text = "Gender: \(response.gender ?? "unknwon")"
                }
            case .failure(let error):
                print("People detail: \(error.localizedDescription)")
            }
        }
    }
}
