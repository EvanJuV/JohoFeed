//
//  ArticleViewController.swift
//  JohoFeed
//
//  Created by HAGANE on 11/21/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var lbFeedName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var linkToSite: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lbAuthor: UILabel!
    
    var article : Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var imagePath = article.imageUrl
        
        if imagePath == nil || imagePath == "" {
            imagePath = ""
            image.image = UIImage(named: "placeholder")
        }
        else {
            let url = URL(string: imagePath!)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            if data != nil {
                image.image = UIImage(data: data!)
            }
        }
        
        lbTitle.text = article.title
        lbAuthor.text = article.author
        lbDescription.text = article.description
        lbFeedName.text = article.feedTitle
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openInBrowser(_ sender: Any) {
        let url = NSURL(string: article.link!)
        UIApplication.shared.openURL(url as! URL)
    }

    @IBAction func likeArticle(_ sender: Any) {
        let url = NSURL(string: "\(Connection.serverHost)/articles/\(article.id)/likedby/\(UserSingleton.sharedInstance.user.id)")
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        // Make asynchrounous call to API
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            print("Liked!")
        }.resume()
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
