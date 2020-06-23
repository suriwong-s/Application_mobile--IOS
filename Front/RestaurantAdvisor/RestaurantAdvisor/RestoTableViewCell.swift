//
//  TableViewCell.swift
//  RestaurantAdvisor
//
//  Created by Sasiporn Suriwong on 04/04/2020.
//  Copyright © 2020 Sasiporn Suriwong. All rights reserved.
//

import UIKit

class RestoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
