//
//  SafariExtensionViewController.swift
//  Messenger Black for Safari
//
//  Created by Ryan Mohta on 7/23/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:240, height:240)
        return shared
    }()
    
    @IBOutlet weak var manuallyEnable: NSButton!
    
    @IBOutlet weak var scheduled: NSButton!
    
    @IBOutlet weak var sunsetToSunrise: NSButton!
    
    @IBOutlet weak var startTime: NSDatePicker!
    
    @IBOutlet weak var endTime: NSDatePicker!
    
    
    
    @IBAction func radioButton(_ sender: Any) {
        if(scheduled.state == NSControl.StateValue.on) {
            startTime.isEnabled = true;
            endTime.isEnabled = true;
        }
        else {
            startTime.isEnabled = false;
            endTime.isEnabled = false;
        }
        
    }
    
}
