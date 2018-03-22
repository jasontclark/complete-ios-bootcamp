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
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        //cell.textLabel?.text = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            // When the checked TodoItem is selected, remove checkmark
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            // When the unchecked TodoItem is selected, add a checkmark
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
        
        // Animate selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add New Todoey Items
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
            
            // Also store the Item in UserDefaults (Local Storage)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // Refresh the tableView to show the
            // newly added item
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}

