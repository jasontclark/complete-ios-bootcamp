//
//  ViewController.swift
//  Todoey
//
//  Created by Jay Clark on 3/9/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    // Removing the hardcoded array
    // var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    
    // Using the Item Model instead of the hardcoded array
    var itemArray = [Item]()
    
    // Path to the custom Item.plist file
    // used to store the Items
    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()

        //print(dataFilePath)
        
        // Constructing Item Data Models
        var newItem = Item()
        newItem.title = "Find Mike"
        newItem.done  = false
        itemArray.append(newItem)
        
        var newItem2 = Item()
        newItem2.title = "Buy Eggos"
        newItem2.done  = false
        itemArray.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        newItem3.done  = false
        itemArray.append(newItem3)
        
        // Retrieving Items from UserDefaults
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
    }

    // MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Setup the Protoype Cell so that it is resusable
        // in the tableView.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // Grab an Item from the itemArray
        let item = itemArray[indexPath.row]
        
        // Set the textLabel in the cell
        // to the title of the Item
        cell.textLabel?.text = item.title
        
        // Add a checkmark if the Item is
        // marked as done
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // If the row is selected, toggle the done
        // property of the item
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        // Toggle the checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            // When the checked TodoItem is selected, remove checkmark
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            // When the unchecked TodoItem is selected, add a checkmark
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // Reload the TableView
        tableView.reloadData()
        
        // Animate selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark - Add New Todoey Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // Create a new Item Data Model Object
            let item = Item()
            
            // Set the title property of the Item Object
            item.title = textField.text!
            
            // Add the Item object to the Item Array
            self.itemArray.append(item)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // Mark - Model Manipulation Methods
    func saveItems() {
        // Also store the ItemArray in a custom PropertyList (Local Storage)
        // using NSCoder
        let encoder = PropertyListEncoder()
        
        // Since the encoding and the writing of the data
        // could throw an error, wrap this in a
        // do-try-catch block
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding Item Array, \(error))")
        }
        
        // Refresh the tableView to show the
        // newly added item
        self.tableView.reloadData()
    }
}

