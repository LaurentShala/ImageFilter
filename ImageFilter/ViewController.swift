//
//  ViewController.swift
//  ImageFilter
//
//  Created by Laurent Shala on 10/14/16.
//  Copyright © 2016 Laurent Shala. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBAction func applyFilterButton(_ sender: UIButton) {
        
    }
    
    
    
    @IBAction func selectPhotoButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!

            present(imagePicker, animated: true, completion: nil)

            }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = chosenImage
        self.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
}

