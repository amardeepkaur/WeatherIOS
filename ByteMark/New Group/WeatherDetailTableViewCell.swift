//
//  WeatherDetailTableViewCell.swift
//  ByteMark
//
//  Created by Amardeep Kaur on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {
    var item: WeatherTableCellViewModel? {
        didSet {
            self.prepareUI()
        }
    }
    
    @IBOutlet weak var weatherDateLabel: UILabel!
    @IBOutlet weak var minimumTempLabel: UILabel!
    @IBOutlet weak var maximumTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareUI() {
        self.minimumTempLabel.text = "Min = \(self.item?.minimumTemperature ?? "")"
        self.maximumTempLabel.text = "Max = \(self.item?.maximumTemperature ?? "")"
        self.weatherDateLabel.text = self.item?.dateString ?? ""
        self.weatherDescriptionLabel.text = "Description: \(self.item?.weatherDescription ?? "")"
    }

}
