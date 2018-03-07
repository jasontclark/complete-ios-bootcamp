//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate,
    UITableViewDataSource, UITextFieldDelegate {
    
    // Declare instance variables here
    var messageArray : [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self

        
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        

        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        // Call the configureTableView func
        // to trigger the custom constraints that
        // allow the cell to expand based on the
        // message size/length.
        configureTableView()
        
        // Call the retrieveMessages func
        // to look for new messages
        retrieveMessages()
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // For all the rows of data, give the TableView a custom cell to display the data.
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "customMessageCell", for: indexPath) as! CustomMessageCell
        
        // Creates a test message array. Each time this func is called,
        // this array gets created.
        //let messageArray = ["First Message", "Second Message", "Third Message"]
        
        // The indexPath.row is used to pick out a message
        // from the messageArray.
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].messageSender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        return cell
    }
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.00
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // Tween animation to animate the
        // increase of the height constraint of the
        // messageTextfield
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 318
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Tween animation to animate the
        // decrease of the height constraint of the
        // messageTextfield
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        // Reference the Message table in the Firebase DB
        let messagesDB = Database.database().reference().child("Messages")
        
        // Create a dictionary for the message
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email,
                                 "MessageBody" : messageTextfield.text!]
        
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if error != nil {
                print(error!)
            } else {
                print("Message saved successfully.")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }
    
    //TODO: Create the retrieveMessages method here:
    func retrieveMessages() {
        
        // Create a reference to the Messages table
        // in the Firebase DB.
        let messageDB = Database.database().reference().child("Messages")
        
        // Use the observe func to watch
        // for new messages added to the Messsages
        // table in the Firebase DB.
        messageDB.observe(.childAdded) { (snapshot) in
            // Cast the new data found in the Messages
            // table to a Dictionary.
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            //let text = snapshotValue["MessageBody"]!
            //let sender = snapshotValue["Sender"]!
            //print(text, sender)
            let message = Message()
            
            message.messageBody = snapshotValue["MessageBody"]!
            message.messageSender = snapshotValue["Sender"]!
            
            // Add the new message to the
            // messageArray
            self.messageArray.append(message)
            
            // Resize the height of the TableView
            self.configureTableView()
            
            // Reload the data in the messageTableView
            self.messageTableView.reloadData()
        }
    }
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error, there was a problem signing out.")
        }
        
        
    }
    


}
