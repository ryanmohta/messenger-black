//
//  ViewController.swift
//  Messenger Black
//
//  Created by Ryan Mohta on 7/11/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import Cocoa
import SafariServices
import CoreLocation

class MyViewController: NSViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.wantsLayer = true

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func openButton(_ sender: Any) {
        
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "com.ryanmohta.Messenger-Black.Messenger-Black-for-Safari") { (error) in
            NSLog("\(String(describing: error))")
        }
    }
    
    @IBAction func enableLocation(_ sender: Any) {
        print("hello")
        locationManager.delegate = self
        
        
//        locationManager.startMonitoringSignificantLocationChanges()
        
//        locationManager.stopUpdatingLocation()
//        locationManager.startUpdatingLocation()
        
        if #available(OSX 10.14, *) {
            locationManager.requestLocation()
        } else {
            // Fallback on earlier versions
        }
        
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            print(".notDetermined")
            break
            
        case .restricted:
            // Disable location features
            print(".restricted")
            break
            
        case .denied:
            print(".denied")
        
        case .authorizedAlways:
            // Enable location features
            print(".authorizedAlways")
            break
        }
        
//        if authorizationStatus != .authorizedAlways {
//            // User has not authorized access to location information.
//            print("Not authorized")
//        }
    
        print(locationManager.location ?? 0)
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last

        print("Last location: \(String(describing: lastLocation))")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopMonitoringSignificantLocationChanges()
            return
        }
        print("Location Error: \(error)")
    }
    
    
    
}

