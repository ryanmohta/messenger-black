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
    }
    
    func scheduledChanged() -> Void {
        let startTimeDate = startTime.dateValue.timeIntervalSince1970 * 1000
        let endTimeDate = endTime.dateValue.timeIntervalSince1970 * 1000
        
        SafariExtensionHandler.currentPage?.dispatchMessageToScript(withName: "Scheduled Changed", userInfo: ["Start Time": startTimeDate, "End Time": endTimeDate])
    }
    
    func sunsetToSunriseChanged() -> Void {
        SafariExtensionHandler.currentPage?.dispatchMessageToScript(withName: "Sunset to Sunrise Changed", userInfo: nil)
    }
    
}
