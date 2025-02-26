//
//  AuthenticationError.swift
//  LoginApp
//
//  Created by Mark Kevin Cagandahan on 2/26/25.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case invalidResponseData
    case requestTimeout
}

extension AuthenticationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return NSLocalizedString("Invalid username or password. Please try again.", comment: "Authentication failure")
        case .invalidResponseData:
            return NSLocalizedString("Unexpected error. Please try again.", comment: "Authentication failure")
        case .requestTimeout:
            return NSLocalizedString("Request timed out.", comment: "Authentication failure")
        }
    }
}
