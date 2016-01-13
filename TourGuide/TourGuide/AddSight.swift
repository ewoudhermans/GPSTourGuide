//
//  AddSight.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Parse
import Bolts

class AddSight: NSObject {
    
    var sightLocation: CLLocation
    var sightInfo: String = ""
    var sightPhoto: UIImage
    
    init(sLocation: CLLocation, sInfo: String, sPhoto: UIImage) {
        self.sightLocation = sLocation
        self.sightInfo = sInfo
        self.sightPhoto = sPhoto
    }
    
    func addSight() {
        var addedSight = PFObject(className: "AddedSight")
        addedSight["SightLocation"] = sightLocation
        addedSight["SightInfo"] = sightInfo
        addedSight["SightPhoto"] = sightPhoto
        addedSight.saveInBackgroundWithBlock({
            (success: Bool, error: NSError?) -> Void in
            
            if error == nil {
                
                //var imageData = UIImagePNGRepresentation(self.sightPhoto.image)
                //var parseImageFile = PFFile(name: "uploaded_image.png", contentsAtPath: imageData)
                
            } else {
                print (error)
            }
        })
    }
}