//
//  ProfileViewController.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    var user: Profile?
    
    override func loadView() {
        self.view = profileView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        
        guard let userId = APIConfigs.shared.currentUserId else { return }
        
        APIConfigs.shared.getUserData(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.user = user
                    self?.profileView.nameLabel.text = user.userName
                    self?.profileView.emailLabel.text = user.email
                }
            case .failure(let error):
                print("Failed to fetch user data: \(error)")
            }
        }
        
        profileView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func editButtonTapped() {
        let alertController = UIAlertController(title: "Edit Name", message: "Enter new name", preferredStyle: .alert)
        alertController.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self, alertController] _ in
            if let newName = alertController.textFields?[0].text {
                guard let userId = self.user?.uid else { return }
                APIConfigs.shared.updateUserProfile(userId: userId, name: newName) { [weak self] result in
                    switch result {
                    case .success():
                        DispatchQueue.main.async {
                            self?.profileView.nameLabel.text = newName
                        }
                    case .failure(let error):
                        print("Failed to update user profile: \(error)")
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
