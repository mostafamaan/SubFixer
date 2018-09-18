//
//  DropZone.swift
//  SubFixer
//
//  Created by Mustafa on 7/15/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import Cocoa

class DropZone: NSView {
    var filePath: String?
    let expectedExt = ["srt"]  //file extensions allowed for Drag&Drop
    @IBOutlet weak var DropLabel: NSTextField!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.gray.cgColor
        
        register(forDraggedTypes: [NSFilenamesPboardType, NSURLPboardType])
    }


    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = NSColor.blue.cgColor
            
            return .copy
        } else {
            return NSDragOperation()
        }
    }

    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as? NSArray,
            let path = board[0] as? String
            else { return false }
        
        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in self.expectedExt {
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as? NSArray,
            let _ = pasteboard[0] as? String
            else { return false }
            for files in pasteboard {
            let file = files as? String
            Swift.print(file!)
            let fileNameUrl = URL.init(fileURLWithPath: file!)
            let fileName = fileNameUrl.lastPathComponent
            let fileContent = readFile(path: file!)
            let srtPath = file?.replacingOccurrences(of: fileName, with: "")
            if fileContent == "" {
                
            }
            else {
            writeFile(fileName: fileName, fileContent: fileContent, filePath: srtPath!)
            }
            
        }
        
        return true
    }
    
    
    func readFile(path:String) -> String {
        var readText = ""
        
        
        do {
            readText = try String.init(contentsOfFile: path)
           
        }
        catch let error as NSError {
            Swift.print(error)
            
        }
        
        return readText
    }
    
    func writeFile(fileName:String,fileContent:String,filePath:String) {
        
        let path = filePath + fileName
        
        let text = fileContent
        do {
            try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            DropLabel.stringValue = "Done drop more :)"
            
           Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: (#selector(DropZone.updateLabel)), userInfo: nil, repeats: true)
            
        }
        
            
        catch let error as NSError {
            Swift.print(error.localizedDescription)
        }
        
    }

    func updateLabel() {
        DropLabel.stringValue = "Drop subtitles here"
        
    }
    
    

}




    

