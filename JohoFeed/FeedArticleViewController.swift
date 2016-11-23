//
//  ArticleViewController.swift
//  JohoFeed
//
//  Created by HAGANE on 11/21/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit

class FeedArticleViewController: UIViewController {
    
    @IBOutlet weak var lbFeedName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var linkToSite: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var webContent: UIWebView!
    
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
        webContent.loadHTMLString("<style type=\"text/css\">img{position: relative;max-width: 100%;max-height: auto;height: auto;}</style><div>\(article.description!)</div>", baseURL: nil)
//        webContent.scrollView.bounces = false
        lbFeedName.text = article.feedTitle
        
        //Set a very low height
//        let heightStr = webContent.stringByEvaluatingJavaScript(from: "document.getElementsByTagName(\"div\")")
//        var height : CGFloat!
//        var frame:CGRect = webContent.frame
//        webContent.frame = frame
//        frame.size.height = 1.0
////        webContent.sizeToFit()
//        print(webContent.scrollView.contentSize.height)
//        
////        if let n = NumberFormatter().number(from: heightStr!) {
////            height = CGFloat(n)
////        }
////        
//        webContent.frame.size.height = webContent.scrollView.contentSize.height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openInBrowser(_ sender: Any) {
        let url = NSURL(string: article.link!)
        UIApplication.shared.openURL(url as! URL)
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
