//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Michael Shustov on 24.10.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check that there's a url
        if articleUrl != nil {
            
            // Create URL object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                print("Couldn't create url object")
                return
            }
            
            // Create the URLRequest object
            let request = URLRequest(url: url!)
            
            // Start spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
            // Load it in the webview
            webView.load(request)
            
        }
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
        spinner.alpha = 0
    }
    
}
