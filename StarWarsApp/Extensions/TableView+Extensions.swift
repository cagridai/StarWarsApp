//
//  TableView+Extensions.swift
//  StarWarsApp
//
//  Created by Çağrı Dai on 29.03.2023.
//

import UIKit

extension UITableView {
    func registerCell(cell: UITableViewCell.Type) {
        let bundle = Bundle(for: cell.self)
        let nib = UINib(nibName: cell.identifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: cell.identifier)
    }
}
