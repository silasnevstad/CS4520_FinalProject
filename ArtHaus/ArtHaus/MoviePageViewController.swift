//
//  MoviePageViewController.swift
//  ArtHaus
//
//  Created by user241517 on 6/21/23.
//

import UIKit

class MoviePageViewController: UIViewController {
    let moviePageView = MoviePageView()
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = moviePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        moviePageView.titleLabel.text = movie.title
        moviePageView.descriptionLabel.text = movie.description
        moviePageView.descriptionLabel.lineBreakMode = .byWordWrapping
        moviePageView.descriptionLabel.text = movie.description
        moviePageView.authorLabel.text = "Author: \(movie.author)"
        moviePageView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        if let url = URL(string: movie.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.moviePageView.imageView.image = image
                    }
                }
            }
        }
    }
    
    @objc func deleteButtonTapped() {
        APIConfigs.shared.deleteMovieIdea(movie: self.movie) { result in
            switch result {
            case .success():
                print("Movie deleted successfully.")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print("Error deleting movie: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "You can only delete your own posts.", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
