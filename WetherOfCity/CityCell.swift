//
//  CityCell.swift
//  WetherOfCity
//
//  Created by Administrator on 07/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet var cityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red: 136.0/255, green: 155.0/255, blue: 218.0/255, alpha: 1.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
