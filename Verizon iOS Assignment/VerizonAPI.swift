//
//  verizonAPI.swift
//  Verizon iOS Assignment
//
//  Created by Anthony on 1/28/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation
import UIKit

struct VerizonAPI {
    
    /**
     Asynchronously fetches JSON data using predetermined URL String.  In this example dummy data was used as a URL string was not provided.
     
     :param: none
     
     :returns: JSONSerialized data in the form of an Array of Dictionaries.
     */
    static func getData(with completion: @escaping ([[String: String]]) -> Void){
        
                                /* Test Data used, no JSON data provided */
        let testReturn = [
           ["name": "Vayne", "image": "http://screenshots.gethopscotch.com/production/nw0lbjn.png" ],
           ["name": "Ekko", "image": "http://screenshots.gethopscotch.com/production/v6h50fr.png"],
           ["name": "Bob", "image": "http://screenshots.gethopscotch.com/production/i18cf2f.png" ],
           ["name": "Tim", "image": "http://screenshots.gethopscotch.com/production/urhwc6r.png"],
           ["name": "Vine", "image": "http://screenshots.gethopscotch.com/production/dmwstcs.png" ],
           ["name": "Elmo", "image": "http://screenshots.gethopscotch.com/production/awd4eol.png"],
           ["name": "Jimmy", "image": "http://screenshots.gethopscotch.com/production/3ew093s.png" ],
           ["name": "Ruby", "image": "http://screenshots.gethopscotch.com/production/raf5wqh.png" ],
           ["name": "Mica", "image": "http://screenshots.gethopscotch.com/production/eewfi6r.png"],
           ["name": "Brohg", "image": "http://screenshots.gethopscotch.com/production/kgtu4bg.png" ],
           ["name": "Vinny", "image": "http://screenshots.gethopscotch.com/production/lba3-fn.png"],
           ["name": "Nancy", "image": "http://screenshots.gethopscotch.com/production/a9fd-x-.png" ],
           ["name": "James", "image": "http://screenshots.gethopscotch.com/production/t-idb7c.png"],
           ["name": "Haverty", "image": "http://screenshots.gethopscotch.com/production/wonxagj.png" ],
           ["name": "Michael", "image": "http://screenshots.gethopscotch.com/production/m7ur8yg.png" ],
           ["name": "Richard", "image": "http://screenshots.gethopscotch.com/production/cnyvmlr.png"],
           ["name": "Steven", "image": "http://screenshots.gethopscotch.com/production/shd9rfs.png" ],
           ["name": "McPhearson", "image": "http://screenshots.gethopscotch.com/production/bd-5dky.png"],
           ["name": "Ricardo", "image": "http://screenshots.gethopscotch.com/production/cledxyn.png" ],
           ["name": "Juniper", "image": "http://screenshots.gethopscotch.com/production/qavg-8v.png"],
           ["name": "Lilly", "image": "http://screenshots.gethopscotch.com/production/mqrtadj.png" ],
           ["name": "Roberto", "image": "http://screenshots.gethopscotch.com/production/gkwy7dv.png" ]
        ]
        
        completion(testReturn)

                    /* BELOW WOULD BE USED TO RETRIEVE TYPICAL JSON DATA FROM A URL PROVIDED */
                    /*
         
        let url = URL(string: "PATH_TO_JSON_DATA_GOES_HERE")
         
            guard let unwrappedURL = url else { return }
         
            let session = URLSession.shared
         
            let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
         
                if let unwrappedData = data {
         
                    do {
         
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: String]]
         
                            completion(responseJSON)
                    
                    } catch {
                    
                    print(error.localizedDescription)
                    
                    }
                }
            }
        task.resume()                                                                       */
    }
 
    /**
     Asynchronously fetches UIImage data using URL String provided by instance of Feed.  In this example dummy data was used as a URL image strings were not provided.
     
     :param: none
     
     :returns: a boolean value representing a successful return of data and a UIImage used to populate a table view cell.
     */
    static func downloadImage(from urlString: String, completion: @escaping(Bool, UIImage?) -> Void) {
        
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else { return }
        
        let request = URLRequest(url: unwrappedURL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else { completion(false, nil); return }
            
            completion(true, image)
        }
        task.resume()
    }
}

