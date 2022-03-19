//
//  SafariExtensionViewController.swift
//  Messenger Black for Safari
//
//  Created by Ryan Mohta on 7/23/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import SafariServices
import CoreLocation
import Foundation

class SafariExtensionViewController: SFSafariExtensionViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var timer: Timer?
    
    
    @IBOutlet weak var manual: NSButton!
    
    @IBOutlet weak var onOff: NSSegmentedControl!
    
    
    @IBOutlet weak var scheduled: NSButton!
    
    @IBOutlet weak var from: NSTextField!
    
    @IBOutlet weak var startTime: NSDatePicker!
    
    @IBOutlet weak var to: NSTextField!
    
    @IBOutlet weak var endTime: NSDatePicker!
    
    
    @IBOutlet weak var sunsetToSunrise: NSButton!
    
    
    
    
    static let shared: SafariExtensionViewController = {
        
        if UserDefaults.standard.bool(forKey: "initialized") == false {
        
            UserDefaults.standard.set(true, forKey: "manual")
            UserDefaults.standard.set(true, forKey: "onOff")
            
            UserDefaults.standard.set(false, forKey: "scheduled")
            UserDefaults.standard.set(382419000, forKey: "startTime")
            UserDefaults.standard.set(382374000, forKey: "endTime")
            
            UserDefaults.standard.set(false, forKey: "sunsetToSunrise")
            
            UserDefaults.standard.set(true, forKey: "initialized")
            
            NSLog("Initialized")
            
        }
        
        let shared = SafariExtensionViewController()
        
        _ = shared.view
        
        shared.preferredContentSize = NSSize(width:240, height:240)
        
        
        shared.manual.state = UserDefaults.standard.bool(forKey: "manual") ? NSControl.StateValue.on : NSControl.StateValue.off
        
        
        shared.onOff.selectedSegment = UserDefaults.standard.bool(forKey: "onOff") ? 1 : 0
        
        
        
        shared.scheduled.state = UserDefaults.standard.bool(forKey: "scheduled") ? NSControl.StateValue.on : NSControl.StateValue.off
        
        shared.startTime.dateValue = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "startTime"))
        
        shared.endTime.dateValue = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "endTime"))
        
        
        shared.sunsetToSunrise.state = UserDefaults.standard.bool(forKey: "sunsetToSunrise") ? NSControl.StateValue.on : NSControl.StateValue.off
        
        shared.radioButtonClicked()
        
        return shared
    }()
    
    
    
    @IBAction func radioButton(_ sender: Any) {
        radioButtonClicked()
    }
    
    @IBAction func onOff(_ sender: Any) {
        manualChanged()
    }
    
    @IBAction func startTime(_ sender: Any) {
        scheduledChanged()
    }
    
    
    @IBAction func endTime(_ sender: Any) {
        scheduledChanged()
    }
    
    
    func radioButtonClicked() -> Void {
        
        if(manual.state == NSControl.StateValue.on) {
            onOff.isEnabled = true
            from.textColor = NSColor.disabledControlTextColor
            startTime.isEnabled = false
            startTime.textColor = NSColor.disabledControlTextColor
            to.textColor = NSColor.disabledControlTextColor
            endTime.isEnabled = false
            endTime.textColor = NSColor.disabledControlTextColor
            
            manualChanged()
        }
        else if(scheduled.state == NSControl.StateValue.on) {
            onOff.isEnabled = false
            from.textColor = NSColor.controlTextColor
            startTime.isEnabled = true
            startTime.textColor = NSColor.controlTextColor
            to.textColor = NSColor.controlTextColor
            endTime.isEnabled = true
            endTime.textColor = NSColor.controlTextColor
            
            scheduledChanged()
        }
        else {
            onOff.isEnabled = false
            from.textColor = NSColor.disabledControlTextColor
            startTime.isEnabled = false
            startTime.textColor = NSColor.disabledControlTextColor
            to.textColor = NSColor.disabledControlTextColor
            endTime.isEnabled = false
            endTime.textColor = NSColor.disabledControlTextColor
            
            sunsetToSunriseChanged()
        }
        
    }
    
    
    func manualChanged() -> Void {
        let state = (onOff.selectedSegment == 0 ? "Off" : "On")
        SafariExtensionHandler.currentPage?.dispatchMessageToScript(withName: "Manual Changed", userInfo: ["State": state])
        
        updateUserDefaults()
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    func scheduledChanged() -> Void {
        let startTimeDate = startTime.dateValue.timeIntervalSince1970 * 1000
        let endTimeDate = endTime.dateValue.timeIntervalSince1970 * 1000
        
        SafariExtensionHandler.currentPage?.dispatchMessageToScript(withName: "Scheduled Changed", userInfo: ["Start Time": startTimeDate, "End Time": endTimeDate])
        
        updateUserDefaults()
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    func sunsetToSunriseChanged() -> Void {
        
        requestLocation()
        
        timer = Timer.scheduledTimer(timeInterval: 86400, target: self, selector: #selector(requestLocation), userInfo: nil, repeats: true)
        timer?.tolerance = 600
        
        updateUserDefaults()
    }
    
    @objc func requestLocation() {
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func updateUserDefaults() -> Void {
        UserDefaults.standard.set(manual.state == NSControl.StateValue.on, forKey: "manual")
        UserDefaults.standard.set(onOff.selectedSegment == 1, forKey: "onOff")
        
        UserDefaults.standard.set(scheduled.state == NSControl.StateValue.on, forKey: "scheduled")
        UserDefaults.standard.set(startTime.dateValue.timeIntervalSince1970, forKey: "startTime")
        UserDefaults.standard.set(endTime.dateValue.timeIntervalSince1970, forKey: "endTime")
        
        UserDefaults.standard.set(sunsetToSunrise.state == NSControl.StateValue.on, forKey: "sunsetToSunrise")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            sendLocationToScript(location: location)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Location Error: \(error)")
    }
    
    
    func sendLocationToScript(location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        SafariExtensionHandler.currentPage?.dispatchMessageToScript(withName: "Sunset to Sunrise Changed", userInfo: ["Latitude": latitude, "Longitude": longitude])
        
    }
    
}
