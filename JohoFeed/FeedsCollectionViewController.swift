//
//  CategoriesCollectionViewController.swift
//  JohoFeed
//
//  Created by alumno on 02/11/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit
import Gloss

private let reuseIdentifier = "feed"

class FeedsCollectionViewController: UICollectionViewController {
    
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate var arrayFeeds : [Feed] = []
    let urlFeeds = URL(string: "\(Connection.serverHost)/api/feeds")
    var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Loading"
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        collectionView?.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !loaded {
            
            activityIndicatorView.startAnimating()
            
            // Make asynchrounous call to API
            let task = URLSession.shared.dataTask(with: urlFeeds! as URL) { data, response, error in
                
                var json: Any!
                
                guard error == nil else {
                    print(error!)
                    
                    OperationQueue.main.addOperation {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                        let alert = UIAlertController(title: "Error", message: "Error on request", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: { UIAlertAction in
                            
                        })
                        
                        alert.addAction(action)
                        
                        self.show(vc!, sender: self)
                        self.show(alert, sender: self)
                    }
                    
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                
                // Parse JSON
                json = try! JSONSerialization.jsonObject(with: data, options: [])
                
                // Cast JSON as array
                let jsonFeeds = json as! NSArray
                
                // Iterate over array and insert each category object
                for jsonFeed in jsonFeeds {
                    guard let feed = Feed(json: jsonFeed as! JSON) else {
                        print("Error while parsing category")
                        return
                    }
                    
                    self.arrayFeeds.append(feed)
                }
                
                OperationQueue.main.addOperation {
                    // Remove spinner and show data
                    self.title = "Feeds"
                    self.activityIndicatorView.stopAnimating()
                    self.collectionView!.reloadData()
                    self.loaded = true
                }
            }
            
            task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "articles" {
            let view = segue.destination as! FeedArticlesTableViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            
            let selectedFeed = arrayFeeds[(indexPath?.row)!]
            view.feedId = selectedFeed.id
            view.feedTitle = selectedFeed.title
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayFeeds.count == 0 ? 0 : 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayFeeds.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        // Configure the cell
        let selectedFeed = arrayFeeds[indexPath.row]
        var imagePath : String? = selectedFeed.logo

        if imagePath == nil {
            imagePath = ""
            cell.imgView.image = UIImage(named: "placeholder")
        }
        else {
            let url = URL(string: imagePath!)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            if data != nil {
                cell.imgView.image = UIImage(data: data!)
            }
        }
        
        cell.backgroundColor = UIColor.white
        cell.lbTitle.text = selectedFeed.title
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

