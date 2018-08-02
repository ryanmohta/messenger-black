//
//  MyCustomAnimator.swift
//  Messenger Black
//
//  Created by Ryan Mohta on 7/29/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import Cocoa

class MyCustomAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let bottomVC = fromViewController
        let topVC = viewController
        topVC.view.wantsLayer = true
        topVC.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        topVC.view.alphaValue = 0
        bottomVC.view.addSubview(topVC.view)
        let frame : CGRect = NSRectToCGRect(bottomVC.view.frame)
        topVC.view.frame = NSRectFromCGRect(frame)
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 0.5
            topVC.view.animator().alphaValue = 1
            
        }, completionHandler: nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let topVC = viewController
        topVC.view.wantsLayer = true
        topVC.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 0.5
            topVC.view.animator().alphaValue = 0
        }, completionHandler: {
            topVC.view.removeFromSuperview()
        })
    }
    

}
