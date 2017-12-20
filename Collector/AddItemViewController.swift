//
//  AddItemViewController.swift
//  Collector
//
//  Created by Lau Chin Wei on 19/12/2017.
//  Copyright © 2017 Yun. All rights reserved.
//

import UIKit
import QuartzCore


class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
// (10) - Add "UIImagePickerControllerDelegate, UINavigationControllerDelegate"
    
    @IBOutlet weak var titleTextField: UITextField! // (2)
    @IBOutlet weak var itemImageView: UIImageView! // (1)
    
    var imagePicker = UIImagePickerController() // (6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self // (9)
        
    }

    @IBAction func photosTapped(_ sender: Any) {
    // (3)
        imagePicker.sourceType = .photoLibrary // (7.1)
        present(imagePicker, animated: true, completion: nil) // (8.1)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera // (7.2)
        present(imagePicker, animated: true, completion: nil) // (8.2)
    // (4)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // (11)
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // (12)
            itemImageView.image = chosenImage
            // (13)
        }
    
        imagePicker.dismiss(animated: true, completion: nil)
        // (14)
    
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
    // (5)
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            // (15)
            
            let item = Item(entity: Item.entity(), insertInto: context)
            // (16)
            
            item.title = titleTextField.text
            // (17)
            
            if let image = itemImageView.image {
            // (18)
                if let imageData = UIImagePNGRepresentation(image) {
                // (19)
                    item.image = imageData
                    // (20)
                }
            }
            
            try? context.save()
            // (21)
            
            navigationController?.popViewController(animated: true)
            // (22)
            
        }
        
    }
    
    
    @IBAction func snapShot(_ sender: Any) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        let activityVC = UIActivityViewController(activityItems: [screenshot!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
        
       /*
        if let window = UIApplication.shared.keyWindow {
            UIGraphicsBeginImageContext(window.frame.size)
            window.layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
            */
        
        /*
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        let activityVC = UIActivityViewController(activityItems: [screenshot!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
 */
    }
    
    /*
    @IBAction func shareButton(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [itemImageView.image!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
 */
}
