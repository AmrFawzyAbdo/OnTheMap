//
//  WebViewController.swift
//  OnTheMap
//
//  Created by Amr on 173//19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import WebKit

class WebViewController: UIViewController , WKNavigationDelegate {
    var urlString: String? = nil
    @IBOutlet var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let url = URL(string: urlString ?? "")!
        let request = URLRequest(url: url)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
}
