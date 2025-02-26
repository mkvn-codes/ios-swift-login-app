//
//  AuthenticationService.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

protocol AuthenticationService {
    func login(with credentials: Credentials, completion: @escaping (Result<Bool, AuthenticationError>) -> Void)
    func logout(completion: @escaping (Bool) -> Void)
}
