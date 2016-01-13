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

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("goSignIn", sender: self)
    }
    
    @IBAction func updateLocation(sender: AnyObject) {
        print (latitude)
        print (longitude)
    }
    
    var locationManager: CLLocationManager!
    
    var latitude = 0.0
    var longitude = 0.0
    
    var location:CLLocation! {
        didSet {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            
        } else {
            self.performSegueWithIdentifier("goSignIn", sender: self)
        }
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //checkCoreLocationPermission()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

