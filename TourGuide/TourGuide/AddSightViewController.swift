//
//  AddSightViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit

class AddSightViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sightTitle: UITextField!
    @IBOutlet weak var sightInfo: UITextField!
    @IBOutlet weak var previewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        previewImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
  
    @IBAction func submitSight(sender: AnyObject) {
        var sightTitleText = sightTitle.text
        var sightInfoText = sightInfo.text
        
        if sightInfoText == nil || sightTitleText == nil {
            print ("Unsifficient information")
        } else {
            
        }
        
    }

}










