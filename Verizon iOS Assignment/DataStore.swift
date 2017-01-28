//
//  DataStore.swift
//  Verizon iOS Assignment
//
//  Created by Anthony on 1/28/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation
import UIKit

class DataStore {
    
    static let shared = DataStore()
    
    var verizonFeeds = [Feed]()
    
    private init(){}

    /**
     It fetches a dictionary from a predetermined URL String, then attaches instances of Feed to the datastore's array.
     
     :param: none
     
     :returns: provides an escaping dictionary used to instantiate instances of the Feed class.
     */
    func getFeedDataFromApi(_ completion: @escaping () -> Void) {
        
        VerizonAPI.getData { (dictionary) in
                
                for i in dictionary {
                    
                    let newFeed = Feed(feed: i)
                    
                    self.verizonFeeds.append(newFeed)
             
                }
                completion()
            }
        }
    
    /**
     It fetches a boolean value and optional UIImage data using a URL String.
     
     :param: url String
     
     :returns: provides an escaping boolean value and image used to populate table view cells.
     */
    func getImageDataFromApi(url: String, completion: @escaping (Bool, UIImage?) -> Void) {
        
        VerizonAPI.downloadImage(from: url, completion: { (bool, image) in
            
            if bool == true {
                
                if let imageReturn = image {
               
                    completion(true, imageReturn)
                
                } else {
                    completion(false, nil)
                }
            }
        })
    }
    
    /**
     Sorts feeds alphabetically from A to Z.
     
     :param: none
     
     :returns: A sorted array.
     */
    func sortFeedsAZ(completion: () -> Void) {
        
        if verizonFeeds.count > 1 {
        
            verizonFeeds = verizonFeeds.sorted(by: { (feedOne, feedTwo) -> Bool in
                
                guard let nameOne = feedOne.name, let nameTwo = feedTwo.name else { return false }
                
                    return nameOne < nameTwo
                
            })
            completion()
        }
    }
    
    /**
     Sorts feeds alphabetically from Z to A.
     
     :param: none
     
     :returns: A sorted array.
     */
    func sortFeedsZA(completion: () -> Void) {
        
        if verizonFeeds.count > 1 {
            
            verizonFeeds = verizonFeeds.sorted(by: { (feedOne, feedTwo) -> Bool in
                
                guard let nameOne = feedOne.name, let nameTwo = feedTwo.name else { return false }
                
                return nameOne > nameTwo
                
            })
            completion()
        }
    }

    /**
     Filters out and shows matching Feed(s) against user submitted string queries.
     
     :param: text String provided by user.
     
     :returns: A filtered array used to populate the tableView.
     */
    func filter(text: String, completion: () -> Void) {
        
        var returnArray = [Feed]()
        
        for feed in verizonFeeds {
            
            if feed.name?.lowercased() == text.lowercased() {

                returnArray.append(feed)
            }
        }
        verizonFeeds = returnArray
        
        completion()
    }
}

