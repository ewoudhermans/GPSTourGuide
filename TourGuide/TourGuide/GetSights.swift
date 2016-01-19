//
//  GetSights.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 18/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import Foundation
import Parse
import Bolts

class GetSights {
    //var sightGeopoint: PFGeoPoint
    var userGeoPoint: PFGeoPoint
    
    init(uGeopoint: PFGeoPoint) {
        //self.sightGeopoint = sGeopoint
        self.userGeoPoint = uGeopoint
    }
    
    func findSight() {

        var query = PFQuery(className:"AddedSight")
        // Interested in locations near user.
        query.whereKey("Geopoints", nearGeoPoint:userGeoPoint)
        // Limit what could be a lot of points.
        query.limit = 10
        // Final list of objects
        do {
            var placesObjects = try query.findObjects()
            print (placesObjects)
        } catch {
            print ("error", error)
        }
    }
}