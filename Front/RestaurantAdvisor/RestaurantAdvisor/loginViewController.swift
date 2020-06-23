//
//  loginViewController.swift
//  RestaurantAdvisor
//
//  Created by Sasiporn Suriwong on 01/04/2020.
//  Copyright © 2020 Sasiporn Suriwong. All rights reserved.
//

import UIKit
import Alamofire

class loginViewController: UIViewController {
    
    @IBOutlet weak var username_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    @IBOutlet weak var login_button: UIButton!
    
    let defaultValues = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton

        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        if defaultValues.string(forKey: "login") != nil{
             self.switchController()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
             let username = username_input.text
             let password = password_input.text
             
             if(username == "" || password == "") {
                 alertMessage(userMessage: "All fields are required");
                 return;
             }
             DoLogin(username!, password!);
         }
         
    func DoLogin(_ user:String, _ psw:String) {
             
             let URL_USER_LOGIN = "http://localhost:8000/api/auth"
            
             //var dataString = "secretWord=44fdcv8jf3"
             
             //dataString = dataString + "&login=\(username_input.text!)" // add items as name and value
             //dataString = dataString + "&password=\(password_input.text!)"
            
             //let data = dataString.data(using: .utf8)
             let parameters: Parameters=[
                 "login":username_input.text!,
                 "password":password_input.text!
             ]
             //making a post request
             AF.request(URL_USER_LOGIN, method: .post, parameters: parameters).validate(statusCode: 200..<300).responseJSON
                 {
                     response in
                     //printing response
                     print(response)
                    
                     switch response.result {
                     case .failure(_):
                        //error message in case of invalid credential
                        self.alertMessage(userMessage: "Invalid username or password")
                        break
                     case .success(_):
                        //switching the screen
                        self.defaultValues.set(self.username_input.text, forKey: "login")
                        self.switchController()
                     }
             }
    }
    
    func switchController(){
        self.performSegue(withIdentifier: "restaurantsViewController", sender: self)
    }
    
    func alertMessage(userMessage:String) {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert);
        
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
    
    }
}
