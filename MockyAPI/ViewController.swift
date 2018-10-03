//
//  ViewController.swift
//  MockyAPI
//
//  Created by Artem Antuh on 10/3/18.
//  Copyright © 2018 Artem Antuh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{

    final let urlString = "http://www.mocky.io/v2/57cffac8260000181e650041"
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var nameArray = [String]()
    var name_engArray = [String]()
    var premiereArray = [String]()
    var descriptionArray = [String]()
    var imgURLArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonWithURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url! as URL), completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "list"))
                
                if let listArray = jsonObj?.value(forKey: "list") as? NSArray {
                    for item in listArray {
                        if let itemDict = item as? NSDictionary {
                            if let name = itemDict.value(forKey: "name") {
                                self.nameArray.append(name as! String)
                            }
                            if let name = itemDict.value(forKey: "name_eng") {
                                self.name_engArray.append(name as! String)
                            }
                            if let name = itemDict.value(forKey: "premiere") {
                                self.premiereArray.append(name as! String)
                            }
                            if let name = itemDict.value(forKey: "description") {
                                self.descriptionArray.append(name as! String)
                            }
                            if let name = itemDict.value(forKey: "image") {
                                self.imgURLArray.append(name as! String)
                            }
                            
                            OperationQueue.main.addOperation({ // run operations in main thread
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }).resume()
    }

    func downloadJsonWithTask() {
        let url = NSURL(string: urlString)
        var downloadTsk = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTsk.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTsk, completionHandler: {(data, response, error) -> Void in
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData)
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return nameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TabelViewCell") as! TableViewCell
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.name_engLabel.text = name_engArray[indexPath.row]
        cell.premiereLabel.text = premiereArray[indexPath.row]
        cell.descriptionLabel.text = descriptionArray[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            
            cell.imgView.image = UIImage(data: data as! Data)
        }
        return cell
    }
    
}

