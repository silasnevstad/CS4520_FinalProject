//
//  ViewController.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import UIKit

class ViewController: UIViewController {
    private var loginScreen: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up/In"
        loginScreen = LoginView()
        view = loginScreen
    }
}
