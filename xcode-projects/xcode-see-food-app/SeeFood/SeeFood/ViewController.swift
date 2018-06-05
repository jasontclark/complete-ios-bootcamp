//
//  ViewController.swift
//  SeeFood
//
//  Created by Jay Clark on 5/15/18.
//  Copyright © 2018 Jay Clark. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    
    // MARK - Image Picker Controller Deletage Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Using optional binding to downcast the
        // dictionary value to a UIImage
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage to CIImage!")
            }
            
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        // Load the Inceptionv3 CoreML model which will be used
        // for the image detection
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading Inceptionv3 CoreML Model failed!")
        }
        
        // Create the Vision request. A callback function is defined
        // for the completion handler
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            print(results)
        }
        
        // Create a ImageRequestHandler object to specify
        // which image you want to run the Vision request on
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Perform the request against the handler
        // i.e the selected image
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
}

