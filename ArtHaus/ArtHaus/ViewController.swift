//
//  ViewController.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import UIKit

class ViewController: UIViewController {

    var movieTitles: [String]!

    private var loginScreen: LoginView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign in"
        loginScreen = LoginView()
        view = loginScreen
        
    }


}

