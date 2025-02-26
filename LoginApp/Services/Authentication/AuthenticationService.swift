//
//  AuthenticationService.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

protocol AuthenticationService {
    func authenticate(with credentials: Credentials, completion: @escaping (Result<[String:Any], AuthenticationError>) -> Void)
}
