//
//  DetailsVC.swift
//  MockyAPI
//
//  Created by Artem Antuh on 10/7/18.
//  Copyright © 2018 Artem Antuh. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imageString: String!
    var nameString: String!
    var descriptionString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI() {
        self.nameLabel.text = nameString
        self.descriptionLabel.text = descriptionString
        
        let imgURL = URL(string: imageString)
        
        let data = NSData(contentsOf: (imgURL)!)
        self.imageView.image = UIImage(data: data! as Data)
    }
    

}
