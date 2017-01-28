//
//  ViewController.swift
//  Verizon iOS Assignment
//
//  Created by Anthony on 1/28/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataStore: DataStore!
    
    var alphaCounter = false
    
    var filtered = false
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBAction func filterByButton(_ sender: Any) {
        
        if filtered == false {

        let alertController = UIAlertController(title: "Filter", message: "Enter Name To Filter", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (searchAction) in }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
            alertController.dismiss(animated: true, completion: nil)
        }
        
        let filterAction = UIAlertAction(title: "Filter", style: UIAlertActionStyle.default) { completion -> Void in
            
            if let unwrappedText = alertController.textFields {
                
                let filterText = unwrappedText[0].text! as String
                
                self.dataStore.filter(text: filterText, completion: {
                        
                        self.tableViewOutlet.reloadData()
                })
            }
        }
        
        alertController.addAction(filterAction)
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
            
        filtered = true
            
        } else {
            
            dataStore.verizonFeeds = []
            
            dataStore.getFeedDataFromApi {
                
                DispatchQueue.main.async {
                    
                    self.tableViewOutlet.reloadData()
                }
            }
            filtered = false
        }
    }

    @IBAction func sortAlphabeticallyButton(_ sender: Any) {
        
        if alphaCounter == false {
        
            dataStore.sortFeedsAZ {
            
                self.tableViewOutlet.reloadData()
                
                alphaCounter = true
            }
            
        } else {
            
            dataStore.sortFeedsZA {
        
                self.tableViewOutlet.reloadData()
            
                alphaCounter = false
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableViewOutlet.delegate = self
       
        tableViewOutlet.dataSource = self
        
        self.dataStore = DataStore.shared
        
        dataStore.getFeedDataFromApi {
            
            DispatchQueue.main.async {
                
                self.tableViewOutlet.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.verizonFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
            cell.textViewOutlet.text = dataStore.verizonFeeds[indexPath.row].name
        
            let arrayIndex = dataStore.verizonFeeds[indexPath.row]
        
            if let imgURL = arrayIndex.imageURL {
                
                self.dataStore.getImageDataFromApi(url: imgURL) { (success, image) in
        
                DispatchQueue.main.async {
                    
                    if success {
            
                        cell.imageViewOutlet.image = image
                    }
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            
            if let dest = segue.destination as? DetailViewController, let indexPath = tableViewOutlet.indexPathForSelectedRow {
                dest.feed = dataStore.verizonFeeds[(indexPath as NSIndexPath).row]
            }
        }
    }

}

    




