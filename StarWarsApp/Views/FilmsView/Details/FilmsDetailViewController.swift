//
//  FilmsDetailViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 5.04.2023.
//

import UIKit

final class FilmsDetailViewController: UIViewController {
    
    @IBOutlet private weak var filmTitle: UILabel!
    @IBOutlet private weak var openingCrawl: UILabel!
    @IBOutlet private weak var director: UILabel!
    @IBOutlet private weak var producer: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    
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

        Network.shared.detailRequest(endpointType: .filmsDetail(url: url), decodingTo: FilmsResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.filmTitle.text = response.title
                    self?.openingCrawl.text = "Opening Crawl: \(response.openingCrawl ?? "")"
                    self?.director.text = "Director: \(response.director ?? "")"
                    self?.producer.text = "Producer: \(response.producer ?? "")"
                    self?.releaseDate.text = "Release Date: \(response.releaseDate ?? "")"
                }
            case .failure(let error):
                print("Film Detail error: \(error.localizedDescription)")
            }
        }
    }
}
