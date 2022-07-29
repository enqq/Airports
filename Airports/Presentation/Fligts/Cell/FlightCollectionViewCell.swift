//
//  FlightCollectionViewCell.swift
//  Airports
//
//  Created by Dawid Karpiński on 19/07/2022.
//

import UIKit

class FlightCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var flightStatusLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setCell(_ arrival: String, _ arrivalT: String, _ departureT: String, _ status: String) {
        arrivalLabel.text = arrival
        arrivalTimeLabel.text = arrivalT
        departureTimeLabel.text = departureT
        flightStatusLabel.text = status
    }
}
