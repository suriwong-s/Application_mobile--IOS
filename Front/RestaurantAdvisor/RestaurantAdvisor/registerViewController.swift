//
//  registerViewController.swift
//  RestaurantAdvisor
//
//  Created by Sasiporn Suriwong on 01/04/2020.
//  Copyright © 2020 Sasiporn Suriwong. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {

    @IBOutlet weak var username_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var lastname_input: UITextField!
    @IBOutlet weak var firstname_input: UITextField!
    @IBOutlet weak var age_input: UITextField!
    @IBOutlet weak var submit_button: UIButton!
    
    let defaultValues = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Register
    
    @IBAction func registerButton(_ sender: Any) {
        
        let username = username_input.text;
        let password = password_input.text;
        let email = email_input.text;
        let lastname = lastname_input.text;
        let firstname = firstname_input.text;
        let age = age_input.text;
        
        //check for empty fields
        
        if(username == "" || password == "" || email == ""
            || lastname == "" || firstname == "" || age == "") {
            
            alertMessage(userMessage: "All fields are required");
            return;
        }
        //stotre data
        
        let myUrl: URL = URL(string: "http://localhost:8000/api/register")!
        var myRequest: URLRequest = URLRequest(url: myUrl);
        myRequest.httpMethod = "POST";
        
        var dataString = "secretWord=44fdcv8jf3"
        
        dataString = dataString + "&login=\(username_input.text!)" // add items as name and value
        dataString = dataString + "&password=\(password_input.text!)"
        dataString = dataString + "&email=\(email_input.text!)"
        dataString = dataString + "&name=\(lastname_input.text!)"
        dataString = dataString + "&firstname=\(firstname_input.text!)"
        dataString = dataString + "&age=\(age_input.text!)"
       
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        
        let task = URLSession.shared.uploadTask(with: myRequest, from: dataD) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            task.resume()
                    
        //alert OK
        
        let myAlert = UIAlertController(title:"Alert", message: "Registration is successful, Thank you", preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default) { action in
            self.defaultValues.set(self.username_input.text, forKey: "login")
            self.performSegue(withIdentifier: "registerTorestaurant", sender: self)
        }
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
    func alertMessage(userMessage:String) {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
    
    }
    
    
}


