//
//  PeopleTableViewCell.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 31.03.2023.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet private var peopleName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurePeopleCell(with response: PeopleResponse) {
        peopleName.text = response.name ?? ""
    }
    
}
