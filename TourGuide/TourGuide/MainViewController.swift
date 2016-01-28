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
    let tabLocation = NSUserDefaults.standardUserDefaults()
    let allSightInfo = NSUserDefaults.standardUserDefaults()
    var userGeoPoint = PFGeoPoint()
    var locationArray: [CLLocationDegrees] = [CLLocationDegrees]()
    var placesObjects = []
    var sighTitles = [String]()
    var sightLocations = []
    var annotations = [MKAnnotation]()
    var whenToUpdate: Bool = true
    var locationManager: CLLocationManager!
    var latitude = 0.0
    var longitude = 0.0
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("goSignIn", sender: self)
    }
    
    @IBAction func updateLocation(sender: AnyObject) {
        self.centerMapOnLocation(self.location)
    }
    
    var location:CLLocation! {
        didSet {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        findSight()
        if whenToUpdate {
            centerMapOnLocation(location)
            whenToUpdate = false
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        whenToUpdate = true
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
        
        } else {
            self.performSegueWithIdentifier("goSignIn", sender: self)
        }
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
    
    func containsAnnotation(annotation: MKAnnotation) -> Bool {
        
        if let existingAnnotations = self.annotations as? [MKAnnotation] {

            for existingAnnotation in existingAnnotations {
                if existingAnnotation.title! == annotation.title!
                    && existingAnnotation.coordinate.latitude == annotation.coordinate.latitude
                    && existingAnnotation.coordinate.longitude == annotation.coordinate.longitude {

                        return true
                }
            }
        }
        return false
    }
    
    func findSight() {
        
        let query = PFQuery(className:"AddedSight")
        userGeoPoint = PFGeoPoint(location: location)
        //query.whereKey("Geopoints", nearGeoPoint: userGeoPoint)
        query.limit = 50
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                
                for object in objects! {
 
                    let Title = String(object["SightTitle"]!)
                    let Lati = object["SightLongitude"] as! Double
                    let Longi = object["SightLatitude"] as! Double
                    let sightLocation = CLLocationCoordinate2DMake(Lati, Longi)
                    self.sighTitles.append(Title)
                
                    let currRegion = CLCircularRegion(center: sightLocation, radius: 10, identifier: Title)
                    self.locationManager.startMonitoringForRegion(currRegion)
                    
                    let annotation = Annotation(title: Title, coordinate: sightLocation)
                    
                        if !self.containsAnnotation(annotation) {
                            
                            self.annotations.append(annotation)
                            self.mapView.addAnnotation(annotation)
                        }
                }
            } else {
                print (error)
            }
        }
    }
    
    func sightNotification(region: CLRegion) {
        let Title = region.identifier
        let query = PFQuery(className: "AddedSight")
        query.whereKey("SightTitle", equalTo: Title)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                let notification = UILocalNotification()
                notification.alertAction = "You are near" + String(objects![0]["SightTitle"])
                notification.alertBody = Title
                
                notification.fireDate = NSDate(timeIntervalSinceNow: 1)
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
                let alertController = UIAlertController(title: Title, message: "Read up about " + Title, preferredStyle: .Alert)
                let yesAction = UIAlertAction(title: "Read!", style: .Default) { (action) -> Void in
                    self.performSegueWithIdentifier("sightReadInfo", sender: self)
                }
                
                self.allSightInfo.setObject(Title, forKey: "sightTitle")
                
                let noAction = UIAlertAction(title: "No thanks", style: .Cancel, handler: nil)
                alertController.addAction(yesAction)
                alertController.addAction(noAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                print (error)
            }
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        sightNotification(region)
        print (region.identifier)
        print (region)
        NSLog("enteringregion")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        NSLog("exit")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NSLog("\(error)")
    }
    
    @IBAction func goSightTableView(sender: AnyObject) {
        locationArray.removeAll()
        
        locationArray.append(location.coordinate.latitude)
        locationArray.append(location.coordinate.longitude)
        userLocation.setObject(locationArray, forKey: "myLocation")
    }
    
    @IBAction func addAnnotation(sender: UILongPressGestureRecognizer) {
        let tabLocation = sender.locationInView(self.mapView)
        let tabCoordinates = self.mapView.convertPoint(tabLocation, toCoordinateFromView: self.mapView)
        let tabAnnotation = MKPointAnnotation()
        tabAnnotation.coordinate = tabCoordinates
        //self.mapView.addAnnotation(tabAnnotation)
        
        let alertController = UIAlertController(title: "Add new sight", message: "Are you sure you want to add a sight at this location?", preferredStyle: .Alert)
        let yesAction = UIAlertAction(title: "Add!", style: .Default) { (action) -> Void in
            
            self.locationArray.append(tabCoordinates.latitude)
            self.locationArray.append(tabCoordinates.longitude)
            self.tabLocation.setObject(self.locationArray, forKey: "myTabLocation")
            self.performSegueWithIdentifier("goAddTabSight", sender: self)
        }
        let noAction = UIAlertAction(title: "No thanks", style: .Cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

