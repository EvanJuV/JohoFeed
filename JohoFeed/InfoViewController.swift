//
//  InfoViewController.swift
//  JohoFeed
//
//  Created by HAGANE on 11/22/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Prepare user before showing this view
        title = "My Information"
        tfUsername.text = UserSingleton.sharedInstance.user.username
        tfEmail.text = UserSingleton.sharedInstance.user.email
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
