//
//  LoginView.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import UIKit



    class LoginView: UIView {
        var textFieldEmail: UITextField!
        var textFieldPassword: UITextField!
        var buttonLogIn: UIButton!
        var buttonSignUp: UIButton!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            
            setupTextFieldEmail()
            setupTextFieldPassword()
            setupButtonLogIn()
            setupButtonSignUp()
        
            initConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupTextFieldEmail(){
            textFieldEmail = UITextField()
            textFieldEmail.placeholder = "Email:"
            textFieldEmail.borderStyle = .roundedRect
            textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textFieldEmail)
        }
        func setupTextFieldPassword(){
            textFieldPassword = UITextField()
            textFieldPassword.placeholder = "Pasword:"
            textFieldPassword.borderStyle = .roundedRect
            textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textFieldPassword)
        }
        
        func setupButtonLogIn(){
            buttonLogIn = UIButton(type: .system)
            buttonLogIn.setTitle("Sign in", for: .normal)
            buttonLogIn.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(buttonLogIn)
            
        }
        
        func setupButtonSignUp(){
            buttonSignUp = UIButton(type: .system)
            buttonSignUp.setTitle("New User? Register Now!", for: .normal)
            buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(buttonSignUp)
            
            
        }
        func initConstraints(){
            NSLayoutConstraint.activate ([
                textFieldEmail.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
                textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                
                textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
                textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                
                buttonLogIn.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
                buttonLogIn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                buttonLogIn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                
                buttonSignUp.topAnchor.constraint(equalTo: buttonLogIn.bottomAnchor, constant: 16),
                buttonSignUp.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                buttonSignUp.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ])
        }
        
    }



