//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Joonwon Lee on 7/23/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.bignerdranch.com")!))
    }
    
}
