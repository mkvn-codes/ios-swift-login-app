//
//  SessionManager.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

protocol SessionManagerDelegate: AnyObject {
    func sessionDidStart(user: SessionUser)
    func sessionDidEnd()
}

class SessionManager {
    weak var delegate: SessionManagerDelegate?
    
    private(set) var currentUser: SessionUser?
    
    func startSession(with user: SessionUser) {
        guard currentUser?.id != user.id else {
            return
        }
        
        self.currentUser = user
        delegate?.sessionDidStart(user: user)
    }
    
    func endSession() {
        self.currentUser = nil
        delegate?.sessionDidEnd()
    }
    
    func isAuthenticated() -> Bool {
        return currentUser != nil
    }
}
