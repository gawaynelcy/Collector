//
//  ItemsTableViewController.swift
//  Collector
//
//  Created by Lau Chin Wei on 19/12/2017.
//  Copyright © 2017 Yun. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var items : [Item] = []
    // (5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) { // (7)
        getItems() // (8)
        
    }
    
    func getItems() {
        // (1)
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            // (2) copy from step (15) of AddItem...ller
            
            if let coreDataStuff  = try? context.fetch(Item.fetchRequest()) as? [Item] {
                // (3)
                if let coreDataItems = coreDataStuff {
                    // (4)
                    items = coreDataItems
                    tableView.reloadData()
                    // (6)
                    
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count // (9)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // (10) copy the withIdentifier: "text" and paste to the Main.Storyboard Table View Cells' "Identifier"
        
        let item = items[indexPath.row]
        // (12)
        
        cell.textLabel?.text = item.title
        // (11)
        
        if let imageData = item.image {
            // (15)
            
            // UIImage(data: imageData) <- Was a code but copied and paste into step 13 as equation
            // (14)
            
            cell.imageView?.image = UIImage(data: imageData) // (13)
        }
        
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
    
}
