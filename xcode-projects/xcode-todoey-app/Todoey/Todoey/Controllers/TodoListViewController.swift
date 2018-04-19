//
//  ViewController.swift
//  Todoey
//
//  Created by Jay Clark on 3/9/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    // Removing the hardcoded array
    // var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    
    // Using the Item Model instead of the hardcoded array
    var itemArray = [Item]()
    
    // Declare the selected Category
    // as an optional since the selected
    // is nil until a category is selected
    // on the CategoryVC
    var selectedCategory : Category? {
        didSet {
            //loadItems()
        }
    }
    
    // Path to the custom Item.plist file
    // used to store the Items
    // let dataFilePath = FileManager.default.urls(for: .documentDirectory,
                                                //in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // Now that we are using CoreData, we need
    // to access the CoreData database. It is
    // provided to us via the AppDelegate
    // inside the persistentContainer
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // Load all of the To-Do Items
        // from the SQLite DB provided
        // by CoreData
        // loadItems()
        
    }

    // MARK: UITableView Datasource Methods
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
    
    // MARK: TableView Delegate Methods
    
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
    
    // MARK: Add New Todoey Items
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//
//        var textField = UITextField()
//
//        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//
//            // Create a new Item Data Model Object
//            //let item = Item()
//
//            // Creates the new item inside
//            // the CoreData database
//            let item = Item(context: self.context)
//
//
//            // Set the title property of the Item Object
//            item.title = textField.text!
//            item.done  = false
//            item.parentCategory = self.selectedCategory
//
//            // Add the Item object to the Item Array
//            self.itemArray.append(item)
//
//            self.saveItems()
//        }
//
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create new item"
//            textField = alertTextField
//        }
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
//
//    }
    
    
    // MARK: DataModel Manipulation Methods
    func saveItems() {
        // Also store the ItemArray in a custom PropertyList (Local Storage)
        // using NSCoder
        // let encoder = PropertyListEncoder()
        
        // Since the saving the data
        // could throw an error, wrap this in a
        // do-try-catch block
        do {
            //let data = try encoder.encode(itemArray)
            //try data.write(to: dataFilePath!)
            
            
            // Saving Item data via CoreData
            try context.save()
        } catch {
            print("Error saving context: \(error))")
        }
        
        // Refresh the tableView to show the
        // newly added item
        self.tableView.reloadData()
    }
    
    // loadItems() method uses an outer parameter (with),
    // and inner parameter (request), and a default argument
    // if no arguments are provided when the method is
    // called (Item.fetchRequest()).
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), withPredicate predicate : NSPredicate? = nil) {
//
//        // Create an NSFetchRequest to request
//        // all of the To-do Items stored in the
//        // SQLite DB (Persistent Container)
//        // let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        // let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        // request.predicate = compoundPredicate
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDescriptor]
//
//        do {
//            // Use the context to execute the request,
//            // return the To-do Item objects,
//            // and store them in the Item array.
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Fetch Request error: \(error)")
//        }
//
//        tableView.reloadData()
//
//    }
}

// MARK: Search Bar Delegate Methods
//extension TodoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        print("Search clicked!")
//
//        // Create the Item fetch request
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        // Create a filter to be used to search
//        // for Item titles that contain the search term
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        // Assign the filter to the fetch Request
//        //request.predicate = predicate
//
//        // Create a sort descriptor to sort
//        // the search results
//        //let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        // Assign the search descriptor to the fetch request
//        //request.sortDescriptors = [sortDescriptor]
//
////        do {
////            // Use the context to execute the request,
////            // return the To-do Item objects,
////            // and store them in the Item array.
////            itemArray = try context.fetch(request)
////        } catch {
////            print("Fetch Request error: \(error)")
////        }
//        loadItems(with: request, withPredicate: predicate)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}
