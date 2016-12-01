//
//  FeedTableViewController.swift
//  JohoFeed
//
//  Created by alumno on 19/10/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit
import Gloss

class FeedTableViewController: UITableViewController {
    
    var categoryId : Int!
    var categoryTitle : String!
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    var urlArticles : URL!
    
    var arrayArticles : [Article] = []
    
    var numOfSections = 1
    var imageCache = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlArticles = URL(string: "\(Connection.serverHost)/api/articles/category/\(categoryId!)")!
        
        self.title = "Loading"
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView?.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView.startAnimating()
        
        arrayArticles = []
        
        // Make asynchrounous call to API
        let task = URLSession.shared.dataTask(with: urlArticles as URL) { data, response, error in
            
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
            let jsonArticles = json as! NSArray
            
            // Iterate over array and insert each category object
            for jsonArticle in jsonArticles {
                guard let article = Article(json: jsonArticle as! JSON) else {
                    print("Error while parsing category")
                    return
                }
                
                self.arrayArticles.append(article)
            }
            
            OperationQueue.main.addOperation {
                if self.arrayArticles.count > 0
                {
                    self.tableView.separatorStyle = .singleLine
                    self.numOfSections                = 1
                    self.tableView.backgroundView = nil
                }
                else
                {
                    let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
                    noDataLabel.text             = "No data available"
                    noDataLabel.textColor        = UIColor.black
                    noDataLabel.textAlignment    = .center
                    self.tableView.backgroundView = noDataLabel
                    self.tableView.separatorStyle = .none
                }
            
                // Remove spinner and show data
                self.title = "\(self.categoryTitle!)"
                self.activityIndicatorView.stopAnimating()
                self.tableView!.reloadData()
            }
        }
        
        task.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayArticles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! FeedTableViewCell
        
        let selectedArticle = arrayArticles[indexPath.row]
        
        cell.imgView.image = UIImage(named: "placeholder")
        
        let imagePath = selectedArticle.imageUrl
        
        if let img = imageCache[imagePath!] {
            cell.imageView?.image = img
        }
        else if imagePath != nil && imagePath != "" {
            
            let url = URL(string: imagePath!)
            
            print(url)
            
            URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
                print("asdfsad")
                if error == nil {
                    
                    let image = UIImage(data: data!)
                    
                    self.imageCache[imagePath!] = image
                    
                    DispatchQueue.main.async {
                        if let cellToUpdate = tableView.cellForRow(at: indexPath) {
                            print("change dis")
                            cellToUpdate.imageView?.image = image
                        }
                    }
                }
                else {
                    print("Error: \(error?.localizedDescription)")
                }
                
            }
            
            //let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            //if data != nil {
                //cell.imgView.image = UIImage(data: data!)
                // self.tableView.reloadData()
            //}
        }
        
        cell.lbTitle?.text = selectedArticle.title
        cell.lbDetail?.text = selectedArticle.description
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "article" {
            let view = segue.destination as! ArticleViewController
            let indexPath = self.tableView!.indexPathForSelectedRow
            
            view.article = arrayArticles[(indexPath?.row)!]
        }
    }
    

}
