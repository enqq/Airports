//
//  CityTableViewCell.swift
//  Airports
//
//  Created by Dawid Karpiński on 12/07/2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(country: String, city: String) {
        self.cityLabel.text = city
        self.countryLabel.text = country
    }
    
}
