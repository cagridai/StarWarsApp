//
//  VehiclesTableViewCell.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 4.04.2023.
//

import UIKit

final class VehiclesTableViewCell: UITableViewCell {

    @IBOutlet private weak var vehiclesName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with response: VehiclesResponse) {
        vehiclesName.text = response.name ?? ""
    }
}
