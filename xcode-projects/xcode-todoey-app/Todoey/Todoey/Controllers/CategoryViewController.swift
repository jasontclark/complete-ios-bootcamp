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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
            // return the To-do Item objects,
            // and store them in the Item array.
            categoryArray = try context.fetch(request)
        } catch {
            print("Category Fetch Request error: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    func saveCategories() {
        // Since the saving the data
        // could throw an error, wrap this in a
        // do-try-catch block
        do {
            // Saving Item data via CoreData
            try context.save()
        } catch {
            print("Error saving Category context: \(error))")
        }
        
        // Refresh the tableView to show the
        // newly added item
        self.tableView.reloadData()
    }
    
    // MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("Todoey: Add Button Pressed!")
    }
    
    // MARK: - TableView Delegate Methods
}
