//
//  WelcomeViewModel.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

class WelcomeViewModel {
    private let sessionManager: SessionManager
    var data: WelcomeData
    
    init(message: String, sessionManager: SessionManager) {
        self.data = WelcomeData(message: message)
        self.sessionManager = sessionManager
    }
    
    func logout() {
        sessionManager.endSession()
    }
}
