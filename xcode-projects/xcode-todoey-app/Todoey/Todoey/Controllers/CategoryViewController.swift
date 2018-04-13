//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jay Clark on 4/11/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    // Stores the Array of Categories
    var categoryArray = [Category]()
    
    // Get a reference to the CoreData context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loads the Categories from
        // persistent storage
        loadCategories()
        
    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // Grab an Category from the categoryArray
        let category = categoryArray[indexPath.row]
        
        // Set the textLabel in the cell
        // to the name of the Category
        cell.textLabel?.text = category.name
        
        return cell
    }
        
    // MARK: - Data Manipulation Methods
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            // Use the context to execute the request,
            // return the Category objects,
            // and store them in the Category array.
            categoryArray = try context.fetch(request)
        } catch {
            print("Category Fetch Request error: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func saveCategories() {
        // Since the saving the data
        // could throw an error, wrap this in a
        // do-try-catch block
        do {
            // Saving Item data via CoreData
            try context.save()
        } catch {
            print("Error saving Category context: \(error)")
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
            let category = Category(context: self.context)
            
            
            // Set the title property of the Item Object
            category.name = textField.text!
            
            self.categoryArray.append(category)
            
            self.saveCategories()
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
}
