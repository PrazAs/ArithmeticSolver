//
//  HelpViewController.swift
//  ArithmeticSolver
//
//  Created by Justin Makaila on 6/15/15.
//  Copyright (c) 2015 Tabtor. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet
    private var helpWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}

private extension HelpViewController {
    func setup() {
        if let helpFileURL = NSBundle.mainBundle().URLForResource("HelpDocument", withExtension: "rtf") {
            let urlRequest = NSURLRequest(URL: helpFileURL)
            helpWebView.loadRequest(urlRequest)
        }
    }
}
