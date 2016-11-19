//
//  LoginViewController.swift
//  JohoFeed
//
//  Created by alumno on 09/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    let keychain = KeychainSwift()
    let urlLogin = URL(string: "\(Connection.serverHost)/api/auth")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let token = keychain.get("access-token")
        
        if token != nil {
            
            let json = ["token": token!] as [String : Any]
            
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                let request = NSMutableURLRequest(url: urlLogin!)
                request.httpMethod = "POST"
                
                // insert json data to the request
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                // Make asynchrounous call to API
                let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                    
                    guard error == nil else {
                        print(error)
                        return
                    }
                    guard let data = data else {
                        print("Data is empty")
                        return
                    }
                    
                    // Parse JSON
                    let jsonRes = try! JSONSerialization.jsonObject(with: data, options: [])
                    
                    // Cast JSON as array
                    let jsonLoginData = jsonRes as! NSDictionary
                    
                    if (jsonLoginData["success"] as? Bool)! {
                        self.performSegue(withIdentifier: "categories", sender: nil)
                    }
                }
                
                task.resume()
            }
            catch {
                print(error)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        if tfUsername.text != nil && tfPassword.text != nil {
            
            let json = ["username": tfUsername.text!, "password": tfPassword.text!] as [String : Any]
            
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                let request = NSMutableURLRequest(url: urlLogin!)
                request.httpMethod = "POST"
                
                // insert json data to the request
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                // Make asynchrounous call to API
                let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                    
                    guard error == nil else {
                        print(error)
                        return
                    }
                    guard let data = data else {
                        print("Data is empty")
                        return
                    }
                    
                    // Parse JSON
                    let jsonRes = try! JSONSerialization.jsonObject(with: data, options: [])
                    
                    // Cast JSON as array
                    let jsonLoginData = jsonRes as! NSDictionary
                    
                    let token = jsonLoginData["token"] as! String
                    
                    let val = self.keychain.set(jsonLoginData["token"] as! String, forKey: "access-token")
                    let retrievedToken = self.keychain.get("access-token")
                    
                    if let value = token.data(using: String.Encoding.utf8) {
                        print("si se puede")
                    }
                    print("hola".data(using: String.Encoding.utf8))
                    
                    let recoveredVal = self.keychain.get("access-token")
                    print(recoveredVal)
                    OperationQueue.main.addOperation {
                        
                        if (jsonLoginData["success"] as? Bool)! {
                            self.performSegue(withIdentifier: "categories", sender: nil)
                        }
                    }
                }
                
                task.resume()
            }
            catch {
                print(error)
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Username and password fields must be filled", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(accion)
            show(alert, sender: self)
        }

    }

}
