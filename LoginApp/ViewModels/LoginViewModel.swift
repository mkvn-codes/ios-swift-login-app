//
//  LoginViewModel.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

class LoginViewModel {
    private let authService: AuthenticationService
    private var credentials = Credentials(username: "", password: "")
    
    var onAuthenticationSuccess: (() -> Void)?
    var onAuthenticationFailure: ((String) -> Void)?
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    func updateCredentials(username: String, password: String) {
        if credentials.username == username && credentials.password == password {
            return
        }
        
        credentials = Credentials(username: username, password: password)
    }
    
    func login() {
        authService.authenticate(with: credentials) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.onAuthenticationSuccess?()
                case .failure(let error):
                    self?.onAuthenticationFailure?(error.localizedDescription)
                }
            }
        }
    }
}

