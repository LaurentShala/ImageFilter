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
    
    
    /// Applies a blur effect to the image
    ///
    /// - parameter inputImage: UIImage that you with to apply the blur effect to
    ///
    /// - returns: UIImage with the blur effect
    func imageBlur(inputImage: UIImage) -> UIImage {
        let context = CIContext(options: nil)
        
        let inputCIImage = CIImage(image: inputImage)!
        
        if let blurFilter = CIFilter(name: "CIGaussianBlur") {
            blurFilter.setValue(inputCIImage, forKey: kCIInputImageKey)
            blurFilter.setValue(8, forKey: kCIInputRadiusKey)
                    
            if let output = blurFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        }
        return UIImage()
    }
    
    /// Applies a blur effect to the image
    ///
    /// - parameter inputImage: UIImage that you with to apply the blur effect to
    ///
    /// - returns: UIImage with the blur effect
    func imageCrystallize(inputImage: UIImage) -> UIImage {
        
        let context = CIContext(options: nil)
        let inputCIImage = CIImage(image: inputImage)!
        
        if let filter = CIFilter(name: "CICrystallize") {
            filter.setValue(inputCIImage, forKey: kCIInputImageKey)
            filter.setValue(55, forKey: kCIInputRadiusKey)
            
            if let output = filter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        }
        return UIImage()
    }
    
    @IBAction func saveImageBarButton(_ sender: UIBarButtonItem) {
        if let imageToBeSaved = photoImageView.image {
            UIImageWriteToSavedPhotosAlbum(imageToBeSaved, nil, nil, nil)
        }
    }
    
   
    @IBAction func applyFilterButton(_ sender: UIButton) {
        photoImageView.image = imageCrystallize(inputImage: photoImageView.image!)
    }
    
    
    @IBAction func selectPhotoButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
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

