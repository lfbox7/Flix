//
//  MoviesTrailerViewController.swift
//  Flix
//
//  Created by Leonard Box on 10/24/19.
//  Copyright © 2019 Leonard Box. All rights reserved.
//

import UIKit
import WebKit

class MoviesTrailerViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var trailerView: WKWebView!
    
    var movie: [String : Any]!
    var movies: [[String : Any]] = []
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = movie["id"]
        let id1 = String(describing: id)
        let cleanId = id1.replacingOccurrences(of: "Optional(", with: "")
        let movieId = cleanId.replacingOccurrences(of: ")", with: "")
        let firstUrl = "https://api.themoviedb.org/3/movie/"
        let lastUrl = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let trailersUrl = URL(string: firstUrl + movieId + lastUrl)!
        let request = URLRequest(url: trailersUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.movies = dataDictionary["results"] as! [[String:Any]]
            }
        
            for data in self.movies {
                var video: [String : Any] = [:]
                for (key, value) in data {
                    video[key] = "\(value)"
                }
                self.movies.append(video)
                let id = video["type"] as? String
                let id1 = String(describing: id)
                let cleanId = id1.replacingOccurrences(of: "Optional(\"", with: "")
                let trailerType = cleanId.replacingOccurrences(of: "\")", with: "")
                let type = "Trailer"
                let baseUrl = "https://www.youtube.com/watch?v="
                
                if trailerType == type {
                    let videoKey = video["key"] as? String
                    let videoUrl = URL(string: baseUrl + videoKey!)
                    print(videoUrl!)
                    let requestLink = URLRequest(url: videoUrl!)
                    self.webView.load(requestLink)
                    self.webView.allowsBackForwardNavigationGestures = true
                }
            }
        }
        task.resume()
    }
    
}
