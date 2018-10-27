//
//  MyCustomSegue.swift
//  Messenger Black
//
//  Created by Ryan Mohta on 7/29/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import Cocoa

class MyCustomSegue: NSStoryboardSegue {
    
    override func perform() {
        let animator = MyCustomAnimator()
        let sourceVC  = self.sourceController as! NSViewController
        let destVC = self.destinationController as! NSViewController
        sourceVC.present(destVC, animator: animator)
    }

}
