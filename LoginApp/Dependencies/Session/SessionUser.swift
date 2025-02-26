//
//  SessionUser.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

struct SessionUser {
    let id: String
    let token: String
    
    init?(from dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let token = dictionary["token"] as? String else {
            return nil
        }
        
        self.id = id
        self.token = token
    }
}
