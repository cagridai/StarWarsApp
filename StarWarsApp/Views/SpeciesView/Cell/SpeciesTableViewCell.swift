//
//  SpeciesTableViewCell.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 3.04.2023.
//

import UIKit

final class SpeciesTableViewCell: UITableViewCell {
    @IBOutlet private weak var speciesName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with response: SpeciesResponse) {
        speciesName.text = response.name ?? ""
    }
    
}
