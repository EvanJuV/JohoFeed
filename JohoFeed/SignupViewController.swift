//
//  SignupViewController.swift
//  JohoFeed
//
//  Created by alumno on 09/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit
import KeychainSwift
import Gloss

class SignupViewController: UIViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    
    let urlSignup = URL(string: "\(Connection.serverHost)/api/auth/signup")
    let keychain = KeychainSwift()
    
    var loginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove keyboard with a tap outside of it
        let tap = UITapGestureRecognizer(target: self, action: #selector (hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signup(_ sender: Any) {
        if tfUsername.text != "" && tfPassword.text != "" && tfEmail.text != "" {
            
            let json = ["username": tfUsername.text!, "password": tfPassword.text!, "email": tfEmail.text!] as [String : Any]
            
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                let request = NSMutableURLRequest(url: urlSignup!)
                request.httpMethod = "POST"
                
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
                    
                    // Parse JSON
                    let jsonRes = try! JSONSerialization.jsonObject(with: data, options: [])
                    
                    // Cast JSON as array
                    let jsonLoginData = jsonRes as! NSDictionary
                    
                    guard let success = jsonLoginData["success"] as? Bool else {
                        OperationQueue.main.addOperation {
                            let alert = UIAlertController(title: "Error", message: "Username is already taken", preferredStyle: .alert)
                            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(accion)
                            self.show(alert, sender: self)
                        }
                        return
                    }
                    
                    guard success else {
                        OperationQueue.main.addOperation {
                            let alert = UIAlertController(title: "Error", message: "Username and/or password are invalid", preferredStyle: .alert)
                            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(accion)
                            self.show(alert, sender: self)
                        }
                        return
                        
                    }
                    
                    let token = jsonLoginData["token"] as! String
                    
                    let val = self.keychain.set(jsonLoginData["token"] as! String, forKey: "access-token")
                    let retrievedToken = self.keychain.get("access-token")
                    
                    if let value = token.data(using: String.Encoding.utf8) {
                        print("si se puede")
                    }
                    print("hola".data(using: String.Encoding.utf8))
                    
                    let recoveredVal = self.keychain.get("access-token")
                    
                    // Assign singleton user
                    let recoveredUser = User(json: jsonLoginData["user"] as! JSON)
                    UserSingleton.sharedInstance.user = recoveredUser!
                    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "categories" {
                if loginSuccess != true {
                    return false
                }
            }
        }
        return true
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
}
