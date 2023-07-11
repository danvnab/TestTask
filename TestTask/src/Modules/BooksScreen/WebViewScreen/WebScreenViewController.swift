//
//  WebScreenViewController.swift
//  TestTask
//
//  Created by Danil Velanskiy on 10.07.2023.
//

import Foundation
import UIKit
import WebKit

final class WebViewController: UIViewController {

    lazy var webView: WKWebView = {
       var webView = WKWebView()
        return webView
    }()
    
    private var shopUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        if let url = shopUrl {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    func loadRequest(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        shopUrl = url
    }
}
