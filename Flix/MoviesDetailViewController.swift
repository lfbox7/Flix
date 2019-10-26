//
//  MoviesDetailViewController.swift
//  Flix
//
//  Created by Leonard Box on 10/21/19.
//  Copyright © 2019 Leonard Box. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesDetailViewController: UIViewController {
    
    var movie: [String : Any]!

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisView.text = movie["overview"] as? String
        synopsisView.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af_setImage(withURL: backdropUrl!)
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        let vc: MoviesTrailerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vc") as! MoviesTrailerViewController
        self.present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        // Pass the selected object to the new view controller.
        let MoviesTrailerViewController = segue.destination as! MoviesTrailerViewController
        MoviesTrailerViewController.movie = movie
    }
}
