//
//  restaurantsViewController.swift
//  RestaurantAdvisor
//
//  Created by Sasiporn Suriwong on 02/04/2020.
//  Copyright © 2020 Sasiporn Suriwong. All rights reserved.
//

import UIKit

struct jsonstruct: Decodable {
    let id:Int
    let name:String
    let description:String
    let grade:Float
    let localization:String
    let phone_number:String
    let website:String
    let hours:String
}

class restaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var logout_button: UIButton!
    
    @IBOutlet weak var RestaurantsTableView: UITableView!
    
    var arrdata = [jsonstruct]()
    
    let defaultValues = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.RestaurantsTableView.delegate = self
        self.RestaurantsTableView.dataSource = self
        // get Jsondta from server
        self.downloadJson()
        
        //hide usernameLabel&logoutbutton
        if (!(defaultValues.string(forKey: "login") != nil)) {
            usernameLabel.isHidden = true;
            logout_button.isHidden = true;
            login_button.isHidden = false;
        } else {
            login_button.isHidden = true;
        
        //hiding back button
            let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
                navigationItem.leftBarButtonItem = backButton
        
        //getting user data from defaults
            if let name = defaultValues.string(forKey: "login"){
            //setting the name to label
            usernameLabel.text = name
            }else{
            //send back to login view controller
            }
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
    
    // LoadJsonData
    func downloadJson() {
        
        let myUrl: URL = URL(string: "http://localhost:8000/api/restaurants")!
        var myRequest: URLRequest = URLRequest(url: myUrl);
        myRequest.httpMethod = "GET";
        
        let task = URLSession.shared.dataTask(with: myRequest) { data, response, error in
            guard let data = data,
                               error == nil else {
                               print(error?.localizedDescription ?? "Response Error")
                               return }
                         do {
                            let decoder = JSONDecoder()
                            self.arrdata = try decoder.decode([jsonstruct].self, from: data)
                            //print(self.arrdata)
                            /*for mainarr in self.arrdata{
                                print(mainarr.name, ":", mainarr.description, ":", mainarr.id)
                            }*/
                            DispatchQueue.main.async {
                                self.RestaurantsTableView.reloadData()
                            }
                        }catch {
                            print("something wrong after dowloaded")
                        }
        };task.resume()
    }
    
    // TableVIew
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        return self.arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RestoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "restaurantsCell") as! RestoTableViewCell
        cell.nameLabel.text = arrdata[indexPath.row].name
        cell.descriptionLabel.text = arrdata[indexPath.row].description
        cell.gradeLabel.text = "\(arrdata[indexPath.row].grade)"
        return cell
    }
    
    // Restaurants Details View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:RestoDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantDetails") as! RestoDetailViewController
        detail.name = arrdata[indexPath.row].name
        detail.descript = arrdata[indexPath.row].description
        detail.grade = "\(arrdata[indexPath.row].grade)"
        detail.localization = arrdata[indexPath.row].localization
        detail.phone_number = arrdata[indexPath.row].phone_number
        detail.website = arrdata[indexPath.row].website
        detail.hours = arrdata[indexPath.row].hours
            self.defaultValues.set(arrdata[indexPath.row].id, forKey: "restaurantID")
            self.present(detail, animated: true, completion: nil)
        //self.navigationController?.pushViewController(detail, animated: true)
    }
    
    //Logout
    @IBAction func LogoutButton(_ sender: UIButton) {
        
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        self.performSegue(withIdentifier: "loginViewController", sender: self)
    }

}
