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
    
    func authenticate(with credentials: Credentials, completion: @escaping (Result<[String:Any], AuthenticationError>) -> Void) {
        let simulatedDelay = Double.random(in: 1...6)  // Simulate random delay between 1-6 seconds
        let timeoutThreshold = 5.0  // Timeout after 5 seconds
        
        DispatchQueue.global().asyncAfter(deadline: .now() + simulatedDelay) {
            if simulatedDelay > timeoutThreshold {
                completion(.failure(.requestTimeout))
                return
            }
            
            if credentials.username == self.username && credentials.password == self.password {
                let response: [String: Any] = [
                    "id": "userIdSample",
                    "token": "userTokenSample"
                ]
                
                completion(.success(response))
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
