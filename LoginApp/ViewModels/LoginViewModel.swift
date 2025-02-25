//
//  LoginViewModel.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

class LoginViewModel {
    private let authService: AuthenticationService
    
    var username = ""
    var password = ""
    
    var onAuthenticationSuccess: (() -> Void)?
    var onAuthenticationFailure: ((String) -> Void)?
    
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    
    func login() {
        let credentials = Credentials(username: self.username, password: self.password)
        
        authService.login(with: credentials) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.onAuthenticationSuccess?()
                case .failure(let error):
                    self?.onAuthenticationFailure?(error.localizedDescription)
                }
            }
        }
    }
}
