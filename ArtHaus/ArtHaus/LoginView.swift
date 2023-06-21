//
//  LoginView.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import UIKit

class LoginView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ArtHaus"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let signInSignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let switchAuthModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Sign Up", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(nameField)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(signInSignUpButton)
        addSubview(switchAuthModeButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            nameField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            nameField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            emailField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            passwordField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor),
            
            signInSignUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInSignUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            signInSignUpButton.widthAnchor.constraint(equalTo: passwordField.widthAnchor),
            signInSignUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            switchAuthModeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            switchAuthModeButton.topAnchor.constraint(equalTo: signInSignUpButton.bottomAnchor, constant: 20),
        ])
        
        // hide the name field initially (logging in)
        nameField.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
