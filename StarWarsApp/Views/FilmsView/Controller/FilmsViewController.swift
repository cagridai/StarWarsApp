//
//  FilmsViewController.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 3.04.2023.
//

import UIKit

final class FilmsViewController: UIViewController {

    @IBOutlet private weak var filmsTableView: UITableView!
    
    private var films: [FilmsResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Films"
        
        filmsTableView.registerCell(cell: FilmsTableViewCell.self)
        filmsTableView.delegate = self
        filmsTableView.dataSource = self
        
        Network.shared.request(endpointType: .films, decodingTo: [FilmsResponse].self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.films.append(contentsOf: response)
                DispatchQueue.main.async {
                    self?.filmsTableView.reloadData()
                }
            case .failure(let error):
                print(CustomError(message: "Films response error: \(error)"))
            }
        }
        
    }
    

}

extension FilmsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = filmsTableView.dequeueReusableCell(withIdentifier: FilmsTableViewCell.identifier, for: indexPath) as? FilmsTableViewCell else { fatalError("FilmsTableViewCell was not found") }
        cell.configureFilmsCell(with: films[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = films[indexPath.row].url else { return }
        self.navigationController?.pushViewController(FilmsDetailViewController(url: url), animated: true)
    }
}
