//
//  ViewController.swift
//  Todoey
//
//  Created by Jay Clark on 3/9/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    // Removing the hardcoded array
    // var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    
    // Using the Item Model instead of the hardcoded array
    // var itemArray = [Item]()
    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    // Declare the selected Category
    // as an optional since the selected
    // is nil until a category is selected
    // on the CategoryVC
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    // Now that we are using CoreData, we need
    // to access the CoreData database. It is
    // provided to us via the AppDelegate
    // inside the persistentContainer
    // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        //let item = itemArray[indexPath.row]
        if let item = todoItems?[indexPath.row] {
            // Set the textLabel in the cell
            // to the title of the Item
            cell.textLabel?.text = item.title
            
            // Add a checkmark if the Item is
            // marked as done
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added."
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    // MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // If the row is selected, toggle the done
        // property of the item
        if let item = todoItems?[indexPath.row] {
            do  {
                try realm.write {
                    
                    //realm.delete(item)
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status: \(error)")
            }
        }
        
        tableView.reloadData()
        
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
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        // Create a new to-do item
                        // via Realm
                        let newItem = Item()
                        
                        // Set the title and done
                        // properties of the Item Object
                        newItem.title = textField.text!
                        
                        // Store the date it was created
                        newItem.dateCreated = Date()
                        
                        // In Realm, we need to add
                        // the new item to the list
                        // of Items available in the selected
                        // category, instead of setting the
                        // parent category for the new item.
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items: \(error)")
                }
                
            }
            
            self.tableView.reloadData()
            
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }
    
    
    // MARK: DataModel Manipulation Methods
    func saveItems() {
        // Also store the ItemArray in a custom PropertyList (Local Storage)
        // using NSCoder
        // let encoder = PropertyListEncoder()
        
        // Since the saving the data
        // could throw an error, wrap this in a
        // do-try-catch block
        // do {
            //let data = try encoder.encode(itemArray)
            //try data.write(to: dataFilePath!)
            
            
            // Saving Item data via CoreData
            //try context.save()
        // } catch {
        //    print("Error saving context: \(error))")
        // }
        
        // Refresh the tableView to show the
        // newly added item
        self.tableView.reloadData()
    }
    
    // loadItems() method uses an outer parameter (with),
    // and inner parameter (request), and a default argument
    // if no arguments are provided when the method is
    // called (Item.fetchRequest()).
    func loadItems() {

        // Using Realm, fetch all of
        // the items associated with
        // the selected category
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()

    }
}

// MARK: Search Bar Delegate Methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        print("Search clicked!")

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
