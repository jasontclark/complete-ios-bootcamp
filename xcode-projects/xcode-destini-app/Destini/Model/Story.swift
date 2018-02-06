//
//  Story.swift
//  Destini
//
//  Created by Jay Clark on 2/6/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Story {
    
    // Text for the Current Story
    var storyText: String!
    
    // Text for answer choice A
    var aAnswer: String!
    
    // Text for answer choice B
    var bAnswer: String!
    
    // Index for next story if answer A is given
    var nextStoryA: Int!
    
    // Index for next story if answer B is given
    var nextStoryB: Int!
    
    // Initializes Story object
    init(story: String, answerA: String, answerB: String, nextStoryIndexA: Int, nextStoryIndexB: Int) {
        
        // Initialize variables
        storyText  = story
        aAnswer    = answerA
        bAnswer    = answerB
        nextStoryA = nextStoryIndexA
        nextStoryB = nextStoryIndexB
    }
    
    // Based on the answer selected, return the index value for the next story
    func getNextStory(answerChosen: String) -> Int {
        if answerChosen == "A" {
            return nextStoryA
        } else {
            return nextStoryB
        }
    }
}
