//
//  ViewController.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 12/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse
import Bolts


class MainViewController: UIViewController, CLLocationManagerDelegate {

    let userLocation = NSUserDefaults.standardUserDefaults()
    var userGeoPoint = PFGeoPoint()
    var locationArray: [CLLocationDegrees] = [CLLocationDegrees]()
    var placesObjects = []
    var sighTitles = [String]()
    var sightLocations = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("goSignIn", sender: self)
    }
    
    @IBAction func updateLocation(sender: AnyObject) {
        //print (latitude)
        //print (longitude)
        
//        let geoCoder = CLGeocoder()
//        let location2 = CLLocation(latitude: latitude, longitude: longitude)
//        
//        geoCoder.reverseGeocodeLocation(location2, completionHandler: { (placemarks, error) -> Void in
//            
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
        
            self.centerMapOnLocation(self.location)

            
        //})
    }
    
    var locationManager: CLLocationManager!
    
    var latitude = 0.0
    var longitude = 0.0
    //var locationArray = [CLLocationDegrees]()
    
    var location:CLLocation! {
        didSet {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            
        } else {
            self.performSegueWithIdentifier("goSignIn", sender: self)
        }
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func checkCoreLocationPermission() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .Restricted {
            print("Give authorization please")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        
        findSight()
        
//        for region in self.locationManager.monitoredRegions {
//            self.locationManager.stopMonitoringForRegion(region)
//        }
        
        centerMapOnLocation(location)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func addSightButton(sender: AnyObject) {
        locationArray.removeAll()
      
        
        locationArray.append(location.coordinate.latitude)
        locationArray.append(location.coordinate.longitude)
        userLocation.setObject(locationArray, forKey: "myLocation")
    }
    
    func findSight() {
        
        let query = PFQuery(className:"AddedSight")
        // Interested in locations near user.
        query.whereKey("Geopoints", nearGeoPoint: userGeoPoint)
        // Limit what could be a lot of points.
        query.limit = 10
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                
                for object in objects! {
 
                    let Title = String(object["SightTitle"]!)
                    let Lati = object["SightLongitude"] as! Double
                    let Longi = object["SightLatitude"] as! Double
                    let sightLocation = CLLocationCoordinate2DMake(Lati, Longi)
                    self.sighTitles.append(Title)
                
                    let currRegion = CLCircularRegion(center: sightLocation, radius: 100, identifier: Title)
                    self.locationManager.startMonitoringForRegion(currRegion)
                
                    let annotation = Annotation(title: Title, coordinate: sightLocation)
                    self.mapView.addAnnotation(annotation)
                    
                }
               
                
            } else {
                print (error)
            }
        }
        
//        // Final list of objects
//        do {
//            placesObjects = try query.findObjects()
//            for place in placesObjects {
//                let Title = String(place["SightTitle"]!)
//                let Lati = place["SightLongitude"] as! Double
//                let Longi = place["SightLatitude"] as! Double
//                let sightLocation = CLLocationCoordinate2DMake(Lati, Longi)
//                sighTitles.append(Title)
//                
//                let currRegion = CLCircularRegion(center: sightLocation, radius: 100, identifier: Title)
//                locationManager.startMonitoringForRegion(currRegion)
//                
//                let annotation = Annotation(title: Title, coordinate: sightLocation)
//                mapView.addAnnotation(annotation)
//            }
//        } catch {
//            print ("error", error)
//        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        NSLog("enteringregion")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        NSLog("exit")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("\(error)")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

