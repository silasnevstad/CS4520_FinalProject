//
//  Profile.swift
//  ArtHaus
//
//  Created by user241517 on 6/12/23.
//

import Foundation
struct Profile{
    var userName:String
    var email:String
    var password: String
    
    init(userName: String, email: String, password: String) {
        self.userName = userName
        self.email = email
        self.password = password
    }
}


