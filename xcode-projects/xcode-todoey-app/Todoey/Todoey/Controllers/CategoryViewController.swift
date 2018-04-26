//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jay Clark on 4/11/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {
    
    // Reference our Realm DB
    let realm = try! Realm()
    
    // Stores a reference to the category
    // data from Realm
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
        
        // Loads the Categories from
        // persistent storage
        loadCategories()
        
    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return categoryArray.count
        
        // Nil Coalescing Operator
        return categories?.count ?? 1
        //return categories.count
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        // Grab an Category from the categories results,
        // Set the textLabel in the cell
        // to the name of the Category
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Created"
        
        cell.delegate = self
        
        return cell
    }
        
    // MARK: - Data Manipulation Methods
    
    func loadCategories() {

        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    
    func save(category: Category) {
        // Since the saving the data
        // could throw an error, wrap this in a
        // do-try-catch block
        do {
            // Saving Item data via CoreData
            //try context.save()
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving Category: \(error)")
        }
        
        // Refresh the tableView to show the
        // newly added item
        tableView.reloadData()
    }
    
    // MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // Creates the new item inside
            // the CoreData database
            //let category = Category(context: self.context)
            let newCategory = Category()
            
            
            // Set the title property of the Category Object
            newCategory.name = textField.text!
            
            newCategory.dateCreated = Date()
            
            //self.categoryArray.append(category)
            //self.categories.append(newCategory)
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}


// MARK: - SwipeCell Delegate Methods
extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("Delete Button Pressed!")
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }

}
