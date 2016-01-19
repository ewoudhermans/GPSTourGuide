//
//  AddSightViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse
import Bolts

class AddSightViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sightTitle: UITextField!
    @IBOutlet weak var sightInfo: UITextField!
    @IBOutlet weak var previewImage: UIImageView!
    
    let userLocation = NSUserDefaults.standardUserDefaults()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0

    var locationArray: [CLLocationDegrees] = [CLLocationDegrees]()
    var city = ""
    
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
        let testArray: AnyObject? = userLocation.objectForKey("myLocation")
        var readArray: [CLLocationDegrees] = testArray! as! [CLLocationDegrees]
        
        latitude = readArray.last!
        longitude = readArray.first!
        
        let sightGeopoint = PFGeoPoint(latitude: longitude, longitude: latitude)
        let sightCenter = CLLocationCoordinate2DMake(longitude, latitude)
        let sightRegion = CLCircularRegion(center: sightCenter, radius: 100, identifier: sightTitle.text!)
        
        print (latitude)
        
        var sightCity: String = ""
        let geoCoder = CLGeocoder()
        var placeMark: CLPlacemark!
        
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: longitude, longitude: latitude), completionHandler: { (placemarks, error) -> Void in
            
            
            placeMark = placemarks?[0]
            print (placeMark.addressDictionary)
            sightCity = placeMark.addressDictionary!["City"] as! String
            print (sightCity)
            //return sightCity
        })
        
        let addsight = AddSight(sInfo: sightInfo.text!, sTitle: sightTitle.text!, sPhoto: previewImage, sLatitude: latitude , sLongitude: longitude, sCity: sightCity, sGeopoint: sightGeopoint)
        addsight.addSight({ (succes) -> Void in
            if succes {
                let alert = self.succesAddedSight()
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
    
    func succesAddedSight() -> UIAlertController {
        let alertView = UIAlertController(title: "Data added", message: "Your sight was successfully added", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Main", style: .Default, handler: { (alertAction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        return alertView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
