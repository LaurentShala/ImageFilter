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
    
    
    func imageSepina(inputImage: UIImage) ->UIImage {
        
        let context = CIContext(options: nil)
        let inputCIImage = CIImage(image: inputImage)!
        
        if let filter = CIFilter(name: "CISepiaTone") {
            filter.setValue(inputCIImage, forKey: kCIInputImageKey)
            filter.setValue(0.8, forKey: kCIInputIntensityKey)
            
            if let output = filter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    
                    let newImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                    //                    let processedImage = UIImage(cgImage: cgimg)
                    return newImage
                }
            }
        }
        return UIImage()

        
        
        
//        print("editImage")
//        let beginImage = CIImage(image: inputImage)
//        let filter = CIFilter(name: "CISepiaTone")
//        filter?.setValue(beginImage, forKey: kCIInputImageKey)
//        filter?.setValue(0.8, forKey: kCIInputIntensityKey)
//        
//        let newImage = UIImage(ciImage: filter!.outputImage!, scale: inputImage.scale, orientation: inputImage.imageOrientation)
//
////        let newImage = UIImage(ciImage: (filter?.outputImage)!)
//        
//        
//        return newImage
    }
    
    
    
    
    
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
            filter.setValue(40, forKey: kCIInputRadiusKey)
            
            if let output = filter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    
                    let newImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
//                    let processedImage = UIImage(cgImage: cgimg)
                    return newImage
                }
            }
        }
        return UIImage()
    }
    
    
    func saveToCameraRoll() {
        if let imageToBeSaved = photoImageView.image {
            UIImageWriteToSavedPhotosAlbum(imageToBeSaved, nil, nil, nil)
            let alert = UIAlertController(title: "Saved!", message: "Image has been saved to camera roll", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert", message: "No image to save", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        photoImageView.image = nil
    }
    
    @IBAction func saveImageBarButton(_ sender: UIBarButtonItem) {
        let saveOptions = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveToCameraRollAction = UIAlertAction(title: "Save to camera roll ", style: .default) { (alert: UIAlertAction) in
            self.saveToCameraRoll()
            print("SAVED TO CAMERA ROLL")
        }
        let saveToFireBaseAction = UIAlertAction(title: "Save to FireBase", style: .default) { (alert: UIAlertAction) in
            print("SAVED TO FIREBASE")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction) in
            print("CANCELED")
        }
        saveOptions.addAction(saveToCameraRollAction)
        saveOptions.addAction(saveToFireBaseAction)
        saveOptions.addAction(cancelAction)
        self.present(saveOptions, animated: true, completion: nil)
    }
    
   
    @IBAction func applyFilterButton(_ sender: UIButton) {
        if photoImageView.image != nil {
            photoImageView.image = imageSepina(inputImage: photoImageView.image!)
        } else {
            let alert = UIAlertController(title: "Alert", message: "No image was selected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("NOPE")
        }
    }
    
    
    @IBAction func selectPhotoButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
//            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            photoImageView.image = image
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = image
        } else {
            dismiss(animated: true, completion: nil)
            photoImageView.image = nil
            let alert = UIAlertController(title: "Alert", message: "Unsupported file, please pick an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        dismiss(animated: true, completion: nil)
        
//        var chosenImage = UIImage()
//        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        photoImageView.image = chosenImage
//        self.dismiss(animated: true, completion: nil);
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
}

