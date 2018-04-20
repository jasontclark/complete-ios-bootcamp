//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jay Clark on 4/11/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    // Reference our Realm DB
    let realm = try! Realm()
    
    // Stores a reference to the category
    // data from Realm
    var categories: Results<Category>!
    //var categories = [Category]()
    
    // Get a reference to the CoreData context
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loads the Categories from
        // persistent storage
        loadCategories()
        
    }
    
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return categoryArray.count
        
        // Nil Coalescing Operator
        //return categories?.count ?? 1
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // Grab an Category from the categoryArray
        //let category = categoryArray[indexPath.row]
        let category = categories[indexPath.row]
        
        // Set the textLabel in the cell
        // to the name of the Category
        cell.textLabel?.text = category.name
        
        return cell
    }
        
    // MARK: - Data Manipulation Methods
    
    func loadCategories() {
//        do {
//            // Use the context to execute the request,
//            // return the Category objects,
//            // and store them in the Category array.
//            categoryArray = try context.fetch(request)
//        } catch {
//            print("Category Fetch Request error: \(error)")
//        }
        
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
}
