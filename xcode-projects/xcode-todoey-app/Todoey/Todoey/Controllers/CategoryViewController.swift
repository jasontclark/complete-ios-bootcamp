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
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    // Reference our Realm DB
    let realm = try! Realm()
    
    // Stores a reference to the category
    // data from Realm
    var categories: Results<Category>?
    var categoryColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
        
        // Loads the Categories from
        // persistent storage
        loadCategories()
        
        tableView.separatorStyle = .none
        
    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Nil Coalescing Operator
        return categories?.count ?? 1

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Calling the SwipeTableVC super class
        // to get access to the cell
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        // Grab an Category from the categories results,
        // Set the textLabel in the cell
        // to the name of the Category
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Created"
        
        if let hexColor = categories?[indexPath.row].hexColor {
            categoryColor = UIColor(hexString: hexColor)
            cell.backgroundColor = categoryColor
        }
        
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
    
    // MARK: Delete from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {
            self.delete(category: category)
        }
    }
    
    
    func delete(category: Category) {
        // Since the saving the data
        // could throw an error, wrap this in a
        // do-try-catch block
        do {
            // Saving Item data via CoreData
            //try context.save()
            try realm.write {
                realm.delete(category)
            }
        } catch {
            print("Error deleting Category: \(error)")
        }
        
        // Refresh the tableView to show the
        // newly added item
        // tableView.reloadData()
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
            
            newCategory.hexColor = UIColor.randomFlat.hexValue()
            
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
        
        if let color = categoryColor {
            destinationVC.categoryColor = color
        }

    }
}
