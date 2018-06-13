//
//  ViewController.swift
//  WhatFlower
//
//  Created by Jay Clark on 6/11/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit
import CoreML
import Vision
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    let imagePicker  = UIImagePickerController()
    let wikipediaURL = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
       
    }

    @IBAction func cameraBtnPressed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    // MARK - UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let userEditedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = userEditedImage
            
            // Convert the Image from a UIImagePickerControllerEditedImage
            // to a CIImage
            guard let ciimage = CIImage(image: userEditedImage) else {
                fatalError("Could not convert UIImage to CIImage!")
            }
            
            detectFlower(withImage: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK - CoreML Flower Detection method
    func detectFlower(withImage image: CIImage) {
        
        // Load the FlowerClassifier CoreML model
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Loading FlowerClassifier model failed!")
        }
        
        // Create a Vision request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image!")
            }
            
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier.capitalized
                self.getWikipediaInfo(from: firstResult.identifier.capitalized)
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        
        // Perform the request against the handler
        // i.e the selected image
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    func getWikipediaInfo(from flowerName: String) {
        let queryParams: [String:String] = [
            "format": "json",
            "action": "query",
            "prop": "extracts",
            "exintro": "",
            "explaintext": "",
            "titles": flowerName,
            "indexpageids": "",
            "redirects": "1",
        ]
        
        Alamofire.request(wikipediaURL, parameters: queryParams).responseJSON { (response) in
            if response.result.isSuccess {
                print("SUCCESS: We have Wikipedia data!")
                
//                guard let responseJSON: JSON = JSON(response.result.value) else { print("FATAL ERROR: JSON response invalid!")}
//                
//                print(responseJSON)
            }
        }
        
    }
    
}

