//
//  StarshipsTableViewCell.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 4.04.2023.
//

import UIKit

final class StarshipsTableViewCell: UITableViewCell {

    @IBOutlet private weak var starshipsName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with response: StarshipsResponse) {
        starshipsName.text = response.name ?? ""
    }
}
