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
    
    var currentDoc: UIDocument?
    
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
        
        closeDoc()
        currentDoc = Document(baseName: "myDoc-\(uuid)")
        currentDoc!.save(to: currentDoc!.fileURL, for: .forCreating) { (completed) in
            if (completed) {
                self.verifyNumberOfFiles()
            }
        }
    }
    
    @IBAction func closeDoc() {
        currentDoc?.close(completionHandler: nil)
    }
    
    @IBAction func share(_ sender: UIButton) {
        guard let currentDoc = currentDoc else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [currentDoc], applicationActivities: nil)
        
        let excludedActivities: [UIActivityType] = [
            .postToFacebook,
            .postToTwitter,
            .postToWeibo,
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToTencentWeibo,
            .openInIBooks]
        activityViewController.excludedActivityTypes = excludedActivities
        
        activityViewController.modalPresentationStyle = .popover
        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.popoverPresentationController?.sourceRect = sender.bounds
        present(activityViewController, animated: true, completion: nil)
    }
    
    func verifyNumberOfFiles() {
        let files = loadFileURLs(from: documentsDirectory)
        self.label.text = "Number of files: \(files?.count ?? 0)"
    }
    
    
}

