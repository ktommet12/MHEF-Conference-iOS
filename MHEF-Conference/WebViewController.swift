//
//  WebViewController.swift
//  MHEF-Conference
//
//  Created by Kyle Tommet on 7/2/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    var urlString: String!
    var isPDF: Bool!

    @IBOutlet weak var goBackBtn: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var goForwardBtn: UIButton!
    
    private let googleDocsViewerUrl = "https://docs.google.com/viewer?url="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if isPDF{
            //self.loadPDF()
            let url = URL(string: googleDocsViewerUrl + urlString)
            webView.loadRequest(URLRequest(url: url!))
            goBackBtn.isEnabled = false
            goForwardBtn.isEnabled = false
        }else{
            let url = URL(string: urlString)
            webView.loadRequest(URLRequest(url: url!))
        }

    }
    @IBAction func btnGoBack(_ sender: Any) {
        if webView.canGoBack{
         webView.goBack()
        }
    }

    @IBAction func refreshPage(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func btnGoForward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    private func loadPDF(){
        if let pdfUrl = Bundle.main.url(forResource: "2017-EvolutionBrochure", withExtension: "pdf", subdirectory: nil, localization: nil){
            do{
                let data = try Data(contentsOf: pdfUrl)
                webView.load(data, mimeType: "application/pdf", textEncodingName:"", baseURL: pdfUrl.deletingLastPathComponent())
                print("pdf file loading")
            }
            catch{
                print("failed to load pdf file")
            }
            return
        }
    }

}
