//
//  BlackView.swift
//  Messenger Black for Safari
//
//  Created by Ryan Mohta on 11/2/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import Cocoa

class BlackView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor(white: 0, alpha: 0.95).setFill()
        dirtyRect.fill()
    }
    
}
