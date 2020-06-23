//
//  RestoModifierVController.swift
//  RestaurantAdvisor
//
//  Created by Sasiporn Suriwong on 05/04/2020.
//  Copyright © 2020 Sasiporn Suriwong. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

struct menuJData: Decodable {
    let id:Int
    let name:String
    let description:String
    let price:Float
}

class menusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let defaultValues = UserDefaults.standard
    
    var menuArray = [menuJData]()
    
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.downloadJson()
    }
    
    func downloadJson() {
        
        let id = defaultValues.string(forKey: "restaurantID")
        
        let myUrl: URL = URL(string: "http://localhost:8000/api/restaurant/2/menus")!
        var myRequest: URLRequest = URLRequest(url: myUrl);
        myRequest.httpMethod = "GET";
        
        let task = URLSession.shared.dataTask(with: myRequest) { data, response, error in
            guard let data = data,
                               error == nil else {
                               print(error?.localizedDescription ?? "Response Error")
                               return }
                         do {
                            let decoder = JSONDecoder()
                            self.menuArray = try decoder.decode([menuJData].self, from: data)
                            print(self.menuArray)
                            /*for mainarr in self.arrdata{
                                print(mainarr.name, ":", mainarr.description, ":", mainarr.id)
                            }*/
                            DispatchQueue.main.async {
                                self.menuTableView.reloadData()
                            }
                        }catch {
                            print("something wrong after dowloaded")
                        }
        };task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        return self.menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuTableViewCell
        cell.nameLabel.text = menuArray[indexPath.row].name
        cell.descriptionLabel.text = menuArray[indexPath.row].description
        cell.priceLabel.text = "\(menuArray[indexPath.row].price)"
        return cell
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
