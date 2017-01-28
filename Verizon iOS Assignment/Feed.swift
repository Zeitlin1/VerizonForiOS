//
//  Feed.swift
//  Verizon iOS Assignment
//
//  Created by Anthony on 1/28/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation
import UIKit

struct Feed {
    
    var name: String?
    
    var imageURL: String?

    init(feed: [String: Any]) {

        name = feed["name"] as! String?
        
        imageURL = feed["image"] as! String?
    }
}


