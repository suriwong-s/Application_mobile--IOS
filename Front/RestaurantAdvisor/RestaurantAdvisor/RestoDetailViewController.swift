//
//  RestoDetailViewController.swift
//  RestaurantAdvisor
//
//  Created by Sasiporn Suriwong on 05/04/2020.
//  Copyright © 2020 Sasiporn Suriwong. All rights reserved.
//

import UIKit

class RestoDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var localizationLabel: UILabel!
    @IBOutlet weak var phone_numberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var name = ""
    var descript = ""
    var grade = ""
    var localization = ""
    var phone_number = ""
    var website = ""
    var hours = ""
    
    @IBOutlet weak var modifierButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let defaultValues = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hide Modifier and Delete button
        if (!(defaultValues.string(forKey: "login") != nil)) {
                modifierButton.isHidden = true;
                deleteButton.isHidden = true;
        } else {
                modifierButton.isHidden = false;
                deleteButton.isHidden = false;
        }
        //
        nameLabel.text = name
        descriptionLabel.text = descript
        gradeLabel.text = grade
        localizationLabel.text = localization
        phone_numberLabel.text = phone_number
        websiteLabel.text = website
        hoursLabel.text = hours
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
