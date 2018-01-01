//
//  Document.swift
//  TestUIDocumentSave
//
//  Created by Papoj Thamjaroenporn on 12/30/17.
//  Copyright © 2017 Papoj Thamjaroenporn. All rights reserved.
//

import UIKit

public var documentsDirectory: URL {
//    return FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}

class Document: UIDocument {
    
    let fileExtension = "myFile"
    
    override init(fileURL url: URL) {
        super.init(fileURL: url)
    }

    /// Convenience method for `init(fileURL:)`
    convenience init(baseName: String) {
        self.init(fileURL: documentsDirectory.appendingPathComponent(baseName).appendingPathExtension("myFile"))
    }
    
    override func contents(forType typeName: String) throws -> Any {
        return NSData()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        
    }
    
}
