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
    
    
    @IBOutlet weak var manual: NSButton!
    
    @IBOutlet weak var onOff: NSSegmentedControl!
    
    
    @IBOutlet weak var scheduled: NSButton!
    
    @IBOutlet weak var from: NSTextField!
    
    @IBOutlet weak var startTime: NSDatePicker!
    
    @IBOutlet weak var to: NSTextField!
    
    @IBOutlet weak var endTime: NSDatePicker!
    
    
    @IBOutlet weak var sunsetToSunrise: NSButton!
    
    
    
    @IBAction func radioButton(_ sender: Any) {
        
        if(manual.state == NSControl.StateValue.on) {
            onOff.isEnabled = true
            from.textColor = NSColor.disabledControlTextColor
            startTime.isEnabled = false
            startTime.textColor = NSColor.disabledControlTextColor
            to.textColor = NSColor.disabledControlTextColor
            endTime.isEnabled = false
            endTime.textColor = NSColor.disabledControlTextColor
            SafariExtensionHandler.currentPage?.dispatchMessageToScript(withName: "Hello", userInfo: nil)
        }
        else if(scheduled.state == NSControl.StateValue.on) {
            onOff.isEnabled = false
            from.textColor = NSColor.controlTextColor
            startTime.isEnabled = true
            startTime.textColor = NSColor.controlTextColor
            to.textColor = NSColor.controlTextColor
            endTime.isEnabled = true
            endTime.textColor = NSColor.controlTextColor
        }
        else {
            onOff.isEnabled = false
            from.textColor = NSColor.disabledControlTextColor
            startTime.isEnabled = false
            startTime.textColor = NSColor.disabledControlTextColor
            to.textColor = NSColor.disabledControlTextColor
            endTime.isEnabled = false
            endTime.textColor = NSColor.disabledControlTextColor
        }
        
    }
    
}
