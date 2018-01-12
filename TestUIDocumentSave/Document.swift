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
    
    static let fileExtension = "myFile"
    
    override init(fileURL url: URL) {
        super.init(fileURL: url)
    }

    /// Convenience method for `init(fileURL:)`
    convenience init(baseName: String) {
        self.init(fileURL: documentsDirectory.appendingPathComponent(baseName).appendingPathExtension(Document.fileExtension))
    }
    
    override func contents(forType typeName: String) throws -> Any {
        return NSData()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        
    }
    
    override func fileAttributesToWrite(to url: URL, for saveOperation: UIDocumentSaveOperation) throws -> [AnyHashable : Any] {
        var attr: [AnyHashable : Any] = [URLResourceKey.hasHiddenExtensionKey: true]
        
        // Ignore the proper resizing for now.
//        guard let thumbnail = self.thumbnail else {
//            return attr
//        }
//
//        let aspectRatio = thumbnail.size.width / thumbnail.size.height
//        let resizedThumbnail = thumbnail.resize(to: CGSize(width: 1024 * (aspectRatio), height: 1024))
        
        attr[URLResourceKey.thumbnailDictionaryKey] = [
            URLThumbnailDictionaryItem.NSThumbnail1024x1024SizeKey: #imageLiteral(resourceName: "Star")
        ]
        
        return attr
    }
    
}

extension Document: UIActivityItemSource {
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return fileURL
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        return fileURL
    }
}
