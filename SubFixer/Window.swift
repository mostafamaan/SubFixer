//
//  Window.swift
//  SubFixer
//
//  Created by Mustafa on 7/15/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import Cocoa

class Window: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window!.titlebarAppearsTransparent = true
        self.window!.titleVisibility = .hidden
        
       // self.window!.styleMask = NSWindowStyleMask.fullSizeContentView
       // self.window.title
        


        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
