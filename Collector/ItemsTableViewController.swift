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
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // (16) Removed comment so that this code will enable "Swipe to Left - Delete" function
        return true
    }
    
    
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        // (17) To make all the step (16) works, this code here must be enabled too by removing comment
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                // (18) copy the "context" code from getItems and paste it here
                let item = items[indexPath.row]
                // (20) this line of code will determine which one to delete as you selected
                context.delete(item)
                // (19)
                getItems()
                // (21) this code will synchronize with the arrays of items and report back to CoreData
            }
        }
    }
    
}
