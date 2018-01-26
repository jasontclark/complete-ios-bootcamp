//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // AVFoundation AVAudioPlayer for playing sound
    var audioPlayer : AVAudioPlayer!
    
    // Array that holds the filenames for each note
    let soundArray = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]
    
    // When the button is pressed, determines which file to play
    var selectedSoundFileName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // Action that is triggered each time a button is pressed
    @IBAction func notePressed(_ sender: UIButton) {
        
        // Based on the tag attribute for each button, select an filename
        // from the array. The -1 is so that we don't end up with an
        // IndexOutOfBounds error
        selectedSoundFileName = soundArray[sender.tag - 1]
        
        // Call the playSound() function
        playSound()
    }
    
    // Plays the wave file selected
    func playSound() {
        
        // Creates the URL path to the sound
        let soundURL = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav")
        
        
        // Exception/Error Handling do-try-catch block
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        
        // Plays the file
        audioPlayer.play()
    }
}

