//
//  ViewController.swift
//  MoodAlarmS
//
//  Created by Angelica Bato on 7/5/16.
//  Copyright © 2016 Angelica Bato. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var currentLocation:CLLocation!
    var latitude:Double!
    var longitude:Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        currentLocation = CLLocation()
        latitude = Double()
        longitude = Double()
        
        getLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Location Services
    
    func getLocation() {
        let locationServiceOn = CLLocationManager.locationServicesEnabled()
        let appHasLaunchedMoreThanOnce = NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedMoreThanOnce")
        
        if locationServiceOn {
            print("Location Services enabled.")
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            if (locationManager.respondsToSelector(#selector(CLLocationManager.requestWhenInUseAuthorization))) {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.startUpdatingLocation()
        }
        else if appHasLaunchedMoreThanOnce{
            let alert = UIAlertController.init(title: "Location Services needed!", message: "Please turn on location services so we can find your current location", preferredStyle: .Alert)
            let settings = UIAlertAction.init(title: "Open Settings", style: .Default, handler: { (action) in
                if let url = NSURL(string:"prefs:root=LOCATION_SERVICES_Systemservices") {
                    UIApplication.sharedApplication().openURL(url)
                }
            })
            let cancel = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
            
            alert.addAction(settings)
            alert.addAction(cancel)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        let alert = UIAlertController.init(title: "Uh Oh!", message: "We couldn't get your location. Please try again.", preferredStyle: .Alert)
        let ok = UIAlertAction.init(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.last
        latitude = currentLocation.coordinate.latitude
        longitude = currentLocation.coordinate.longitude
        locationManager.stopUpdatingLocation()
        
        print("Current Location: \(currentLocation), Lat: \(latitude), Long: \(longitude)")
        
//        updateLocationInfo()
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .NotDetermined:
            print("User still thinking...")
            self.locationManager.requestWhenInUseAuthorization()
            break
        case .Denied:
            print("User hates you")
            let alert = UIAlertController.init(title: "Sorry!", message: "This app won't work without Location Services Authorization.", preferredStyle: .Alert)
            let action = UIAlertAction.init(title: "Open Settings", style: .Default, handler: { (action) in
                print("User pressed ok")
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            })
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            break
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            self.locationManager.startUpdatingLocation()
            break
        default:
            break
        }
        
    }

    


}

