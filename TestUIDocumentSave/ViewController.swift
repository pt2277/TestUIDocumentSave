//
//  ViewController.swift
//  TestUIDocumentSave
//
//  Created by Papoj Thamjaroenporn on 12/30/17.
//  Copyright © 2017 Papoj Thamjaroenporn. All rights reserved.
//

import UIKit

func loadFileURLs(from dirURL: URL) -> [URL]? {
    return try? FileManager().contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil)
}

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createDoc(_ sender: Any) {
        let uuid = UUID().uuidString
        let doc = Document(baseName: "myDoc-\(uuid)")
        doc.save(to: doc.fileURL, for: .forCreating) { (completed) in
            if (completed) {
                doc.close(completionHandler: nil)
                self.verifyNumberOfFiles()
            }
        }
    }
    
    func verifyNumberOfFiles() {
        let files = loadFileURLs(from: documentsDirectory)
        self.label.text = "Number of files: \(files?.count ?? 0)"
    }
    
    
}

