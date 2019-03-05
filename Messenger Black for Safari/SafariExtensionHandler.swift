//
//  SafariExtensionHandler.swift
//  Messenger Black for Safari
//
//  Created by Ryan Mohta on 7/23/18.
//  Copyright © 2018 Ryan Mohta. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    static var activated = true
    
    static var currentPage: SFSafariPage? = nil
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        
        SafariExtensionHandler.currentPage = page
        
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
        if SafariExtensionHandler.activated {
            page.dispatchMessageToScript(withName: "ExtensionOn", userInfo: nil)
        }
        else {
            page.dispatchMessageToScript(withName: "ExtensionOff", userInfo: nil)
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
        
        do {
            let path = URL(fileURLWithPath: "/Users/ryanmohta/Documents/XCode apps/Messenger Black/Messenger Black for Safari/data.txt")
            
            //let path = Bundle.main.path(forResource: "data", ofType: "txt")
            let text = "It worked!!"
            try text.write(to: path, atomically: false, encoding: .utf8)
        }
        catch {
            print(error)
        }
        
        window.getToolbarItem { (toolbarItem) in
            if SafariExtensionHandler.activated {
                toolbarItem?.setImage(NSImage(named: "ToolbarItemIcon_Off.pdf"))
                
                window.getActiveTab { (activeTab) in
                    activeTab?.getActivePage { (activePage) in
                        activePage?.dispatchMessageToScript(withName: "ExtensionOff", userInfo: nil)
                    }
                }
                
                SafariExtensionHandler.activated = false
            }
            else {
                toolbarItem?.setImage(nil)
                
                window.getActiveTab { (activeTab) in
                    activeTab?.getActivePage { (activePage) in
                        activePage?.dispatchMessageToScript(withName: "ExtensionOn", userInfo: nil)
                    }
                }
                
                SafariExtensionHandler.activated = true
            }
        }
        
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
