//
//  DetailViewController.swift
//  Verizon iOS Assignment
//
//  Created by Anthony on 1/28/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var feed: Feed!
    
    let dataStore = DataStore.shared
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = feed.name
        
        if let imgURL = feed.imageURL {
            
            self.dataStore.getImageDataFromApi(url: imgURL) { (success, image) in
                
                DispatchQueue.main.async {
                    
                    if success {
                        
                        self.detailImageView.image = image
                    }
                }
            }
        }
    }
}
