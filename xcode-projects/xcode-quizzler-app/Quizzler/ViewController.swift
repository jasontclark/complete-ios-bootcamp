//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions                = QuestionBank()
    var pickedAnswer : Bool         = false
    var currentQuestion : Question? = nil
    var currentQuestionNum : Int    = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestion = allQuestions.list[currentQuestionNum]
        questionLabel.text = currentQuestion?.questionText
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
        questionLabel.text = currentQuestion?.questionText
    }
    

    func nextQuestion() {
        currentQuestionNum += 1
        if currentQuestionNum <= 12 {
        currentQuestion = allQuestions.list[currentQuestionNum]
        } else {
            // Create the alert popup.
            let alert = UIAlertController(title: "End of Quiz.", message: "You have reached the end of the quiz. Would you like to play again?", preferredStyle: .alert)
            
            // Create the alert action

            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            // Add the alert action to the popup
            alert.addAction(restartAction)
            
            // Show the alert on the screen.
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = currentQuestion?.answer
        
        if pickedAnswer == correctAnswer {
            print("You got it!")
        } else {
            print("Wrong!")
        }
    }
    
    
    func startOver() {
       currentQuestionNum = 0
       currentQuestion    = allQuestions.list[currentQuestionNum]
       questionLabel.text = currentQuestion?.questionText
    }
    

    
}
