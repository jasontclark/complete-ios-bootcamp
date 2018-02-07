//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    // TODO Step 5: Initialise instance variables here
    let allStories           = StoryBank()
    var currentStoryNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the first story
        nextStory()
    }

    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        // Load the current story
        let currentStory = allStories.list[currentStoryNum]
        
        // Placeholder variable for the next story
        var nextStoryNum = 0
        
        // TODO Step 4: Write an IF-Statement to update the views
        if sender.tag == 1 {
            // Use the getNextStory() function in the Story object
            // when the answer option is A.
            nextStoryNum = currentStory.getNextStory(answerChosen: "A")
        } else {
            // Use the getNextStory() function in the Story object
            // when the answer option is B.
            nextStoryNum = currentStory.getNextStory(answerChosen: "B")
        }
                
        // Update the currentStoryNum with the nextStoryNum
        currentStoryNum = nextStoryNum
        
        // Load the next story
        nextStory()
    }
    
    // nextStory() takes care of loading the next story on the view.
    func nextStory() {
        // Loads the next story from the StoryBank()
        let currentStory = allStories.list[currentStoryNum]
        
        // Updates the story text on the view
        storyTextView.text = currentStory.storyText
        
        // Checks to see if the buttons need to be loaded
        // If so, the text is updated on them.
        if currentStoryNum <= 2 {
            // Only the first 3 stories have answer choices.
            topButton.setTitle(currentStory.aAnswer, for: UIControlState.normal)
            bottomButton.setTitle(currentStory.bAnswer, for: UIControlState.normal)
        } else {
            // The 4th, 5th, and 6th stories do not.
            topButton.isHidden    = true
            bottomButton.isHidden = true
        }
        
    }

}

