//
//  SampleAuthenticationService.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

class SampleAuthenticationService: AuthenticationService {
    let username = "admin"
    let password = "12345"
    
    func login(with credentials: Credentials, completion: @escaping (Result<Bool, AuthenticationError>) -> Void) {
        if !isValid(credentials) {
            completion(.failure(.invalidCredentials))
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            if credentials.username == self.username && credentials.password == self.password {
                completion(.success(true))
            } 
            else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            completion(true)
        }
    }
    
    func isValid(_ credentials: Credentials) -> Bool {
        !credentials.username.isEmpty && !credentials.password.isEmpty
    }
}
