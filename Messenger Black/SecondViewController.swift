//
//  SecondViewController.swift
//  Messenger Black
//
//  Created by Ryan Mohta on 7/28/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import Cocoa
import SafariServices

class SecondViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func openButton(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "com.ryanmohta.Messenger-Black.Messenger-Black-for-Safari") { (error) in
            NSLog("Error \(String(describing: error))")
        }
    }
    
}
