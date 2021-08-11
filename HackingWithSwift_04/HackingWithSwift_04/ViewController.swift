//
//  ViewController.swift
//  HackingWithSwift_04
//
//  Created by Bárbara Tiefensee on 09/08/21.
//
import SnapKit
import WebKit
import UIKit

class ViewController: UIViewController {
    
    var webView = WKWebView()
    var progressView = UIProgressView()
    var websites = ["apple.com", "hackingwithswift.com", "google.com", "google.com/swiftTest"]
    var webLoad = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monitoringPageLoad()
        urlWKWebView()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webConfiguration)
        webView.navigationDelegate = self
        self.view = webView
    }
    
    private func urlWKWebView() {
        guard let url = URL(string: "https://" + webLoad) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func monitoringPageLoad() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [ progressButton, spacer, back, forward, refresh]
        navigationController?.isToolbarHidden = false
        
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            if host.contains(webLoad) {
                decisionHandler(.allow)
                return
            } else {
                let alert = UIAlertController(title: "WARNING!", message: "This website is not secure.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { actoin in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                present(alert, animated: true, completion: nil)
            }
        }
        decisionHandler(.cancel)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "EstimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

