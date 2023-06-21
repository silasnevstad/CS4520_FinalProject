//
//  LoginViewController.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import FirebaseAuth

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    var loginView: LoginView!
    var isSignInMode: Bool = true
    
    override func loadView() {
        loginView = LoginView()
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.signInSignUpButton.addTarget(self, action: #selector(handleSignInSignUp), for: .touchUpInside)
        loginView.switchAuthModeButton.addTarget(self, action: #selector(handleSwitchAuthMode), for: .touchUpInside)
    }
    
    @objc func handleSignInSignUp() {
        guard let email = loginView.emailField.text,
              let password = loginView.passwordField.text else {
            print("Form is not valid")
            return
        }

        if isSignInMode {
            APIConfigs.shared.signIn(withEmail: email, password: password) { result in
                switch result {
                case .success(let user):
                    print("Successfully signed in: \(user)")
                    let homeVC = HomeScreenViewController()
                    self.navigationController?.pushViewController(homeVC, animated: true)
                case .failure(let error):
                    print("Failed to sign in: \(error)")
                }
            }
        } else {
            guard let name = loginView.nameField.text else {
                print("Missing name")
                return
            }
            APIConfigs.shared.signUp(withEmail: email, password: password, name: name) { [weak self] result in
                switch result {
                case .success(let user):
                    print("Successfully signed up: \(user)")
                    let homeVC = HomeScreenViewController()
                    self?.navigationController?.pushViewController(homeVC, animated: true)
                case .failure(let error):
                    print("Failed to sign up: \(error)")
                }
            }
        }
    }
    
    func updateUserProfile(userId: String, name: String? = nil, profilePicURL: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        if let name = name {
            changeRequest?.displayName = name
        }
        changeRequest?.photoURL = URL(string: profilePicURL)
        changeRequest?.commitChanges(completion: { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }
    
    @objc func handleSwitchAuthMode() {
        isSignInMode.toggle()
        let title = isSignInMode ? "Sign In" : "Sign Up"
        let buttonTitle = isSignInMode ? "Don't have an account? Sign Up" : "Already have an account? Sign In"
        loginView.signInSignUpButton.setTitle(title, for: .normal)
        loginView.switchAuthModeButton.setTitle(buttonTitle, for: .normal)
        
        // Toggle visibility of name field, profile image view and change profile picture button
        loginView.nameField.isHidden = isSignInMode
    }
}
