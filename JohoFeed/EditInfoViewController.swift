//
//  EditInfoViewController.swift
//  JohoFeed
//
//  Created by HAGANE on 11/22/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit
import Gloss

class EditInfoViewController: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    
    let urlPut = URL(string: "\(Connection.serverHost)/users/\(UserSingleton.sharedInstance.user.id)")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Edit Information"
        tfUsername.text = UserSingleton.sharedInstance.user.username
        tfEmail.text = UserSingleton.sharedInstance.user.email
        tfPassword.text = "password"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateUser(_ sender: Any) {
        
        var json : [String : Any] = [:]
        
        if tfEmail.text != "" && tfUsername.text != nil {
            json = ["username": tfUsername.text!, "email": tfEmail.text!] as [String : Any]
        }
        else if tfEmail.text != "" && tfUsername.text != nil && tfPassword.text != nil {
            json = ["username": tfUsername.text!, "password": tfPassword.text!, "email": tfEmail.text!] as [String : Any]
        }
            
        do {
                
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
            let request = NSMutableURLRequest(url: urlPut!)
                request.httpMethod = "PUT"
                
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
                
            // Make asynchrounous call to API
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                    
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                print(data)
                // Parse JSON
                let jsonRes = try! JSONSerialization.jsonObject(with: data, options: [])

                // Assign singleton user
                let updatedUser = User(json: jsonRes as! JSON)
                UserSingleton.sharedInstance.user = updatedUser
                
                OperationQueue.main.addOperation {
                    if updatedUser != nil {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
                
            task.resume()
        }
        catch {
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
