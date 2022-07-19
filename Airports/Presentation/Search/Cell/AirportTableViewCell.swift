//
//  AirportTableViewCell.swift
//  Airports
//
//  Created by Dawid Karpiński on 18/07/2022.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var iataCodeLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ iataCode: String, _ timezone: String?, _ airportName: String, _ countryCode: String) {
        self.iataCodeLabel.text = iataCode
        //self.timezoneLabel.text = timezone
        self.airportNameLabel.text = airportName
        self.countryCodeLabel.text = countryCode
    }
}
