//
//  PlanetsTableViewCell.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 29.03.2023.
//

import UIKit

final class PlanetsTableViewCell: UITableViewCell {
    @IBOutlet private weak var planetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with response: PlanetResponse) {
        planetName.text = response.name ?? ""
    }
}
