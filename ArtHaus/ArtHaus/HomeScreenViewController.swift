//
//  HomeScreenViewController.swift
//  ArtHaus
//
//  Created by user241517 on 6/21/23.
//

import UIKit

class HomeScreenViewController: UIViewController {
    let homeScreenView = HomeScreenView()
    var movieIdeas: [Movie] = []
    
    override func loadView() {
        self.view = homeScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupNavigationBarButtons()
        homeScreenView.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieIdeaCell")
        homeScreenView.tableView.delegate = self
        homeScreenView.tableView.dataSource = self
        loadMovieIdeas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovieIdeas()
    }
    
    func setupNavigationBarButtons() {
        let accountButton = UIBarButtonItem(title: "Account", style: .plain, target: self, action: #selector(didTapAccountButton))
        let createMovieButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateMovieButton))
        
        navigationItem.rightBarButtonItem = createMovieButton
        navigationItem.leftBarButtonItem = accountButton
    }
    
    @objc func didTapAccountButton() {
        let profilePage = ProfileViewController()
        self.navigationController?.pushViewController(profilePage, animated: true)
    }
    
    @objc func didTapCreateMovieButton() {
        let createMoviePage = CreateMovieViewController()
        self.navigationController?.pushViewController(createMoviePage, animated: true)
    }
    
    func loadMovieIdeas() {
        APIConfigs.shared.getMovieIdeas { result in
            switch result {
            case .success(let movieIdeas):
                self.movieIdeas = movieIdeas
                DispatchQueue.main.async {
                    self.homeScreenView.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to load movie ideas: \(error)")
            }
        }
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieIdeas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieIdeaCell", for: indexPath) as! MovieTableViewCell
        let movieIdea = movieIdeas[indexPath.row]

        cell.titleLabel.text = movieIdea.title

        // Display the first 50 characters of the description, or the entire description if it's shorter than 50 characters
        let descriptionPreview = String(movieIdea.description.prefix(20))
        cell.descriptionLabel.text = movieIdea.description.count > 20 ? "\(descriptionPreview)..." : descriptionPreview

        cell.authorLabel.text = "By \(movieIdea.author)"
        cell.movieImageView.image = UIImage(systemName: "questionmark.square.dashed")

        // Asynchronously load the image
        if let url = URL(string: movieIdea.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // Check if the cell is still on screen and hasn't been reused
                        if tableView.cellForRow(at: indexPath) == cell {
                            cell.movieImageView.image = image
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieIdea = movieIdeas[indexPath.row]
        let moviePageViewController = MoviePageViewController(movie: movieIdea)
        self.navigationController?.pushViewController(moviePageViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
