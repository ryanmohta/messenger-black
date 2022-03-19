//
//  ViewController.swift
//  Messenger Black
//
//  Created by Ryan Mohta on 7/11/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import Cocoa
import SafariServices

class MyViewController: NSViewController {
    
    
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
    
    @IBAction func finishButton(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}
