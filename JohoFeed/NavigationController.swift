//
//  NavigationController.swift
//  JohoFeed
//
//  Created by HAGANE on 11/22/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Change the color of the navigation bar title text to yellow.
        self.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor(hue: 352/360, saturation: 0/100, brightness: 100/100, alpha: 1.0) /* #ffffff */]
        self.navigationBar.barTintColor = UIColor(hue: 352/360, saturation: 68/100, brightness: 100/100, alpha: 1.0) /* #ff516a */
        self.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
