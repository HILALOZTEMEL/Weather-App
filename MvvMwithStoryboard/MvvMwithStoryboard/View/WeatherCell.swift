//
//  WeatherCell.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 29.03.2023.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var Temp2Label: UILabel!
    @IBOutlet weak var Temp1Label: UILabel!
    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var DayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
