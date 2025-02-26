//
//  LoginViewModel.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

class LoginViewModel {
    // Dependencies
    private let authService: AuthenticationService
    private let sessionManager: SessionManager
    
    // Model
    private var credentials = Credentials(username: "", password: "") {
        didSet {
            onCredentialsUpdate?()
        }
    }
    
    var hasValidCredentials: Bool {
        get {
            return !credentials.username.isEmpty && !credentials.password.isEmpty
        }
    }
    
    // Callbacks
    var onAuthenticationSuccess: (() -> Void)?
    var onAuthenticationFailure: ((String) -> Void)?
    var onCredentialsUpdate: (() -> Void)?
    
    init(authService: AuthenticationService, sessionManager: SessionManager) {
        self.authService = authService
        self.sessionManager = sessionManager
    }
    
    func updateCredentials(username: String, password: String) {
        if credentials.username == username && credentials.password == password {
            return
        }
        
        credentials = Credentials(username: username, password: password)
    }
    
    func login() {
        if !hasValidCredentials {
            self.onAuthenticationFailure?(AuthenticationError.invalidCredentials.localizedDescription)
            return
        }
        
        authService.authenticate(with: credentials) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let sessionUser = SessionUser(from: response) {
                        self?.sessionManager.startSession(with: sessionUser)
                        self?.onAuthenticationSuccess?()
                    }
                    else {
                        self?.onAuthenticationFailure?(AuthenticationError.invalidResponseData.localizedDescription)
                    }
                case .failure(let error):
                    self?.onAuthenticationFailure?(error.localizedDescription)
                }
            }
        }
    }
}

