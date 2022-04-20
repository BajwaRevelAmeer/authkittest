//
//  AuthKitError.swift
//  
//
//  Created by Revel on 2022-03-10.
//

import Foundation
import struct Auth0.CredentialsManagerError
import struct Auth0.WebAuthError

public struct AuthKitError: LocalizedError, Equatable {
    /**
     The underlying `Error` code value
     */
    public let code: Code
    
    public init(code: Code) {
        self.code = code
    }
}

extension AuthKitError: CustomDebugStringConvertible {
    /**
     Description of the error.
     
     - Important: You should avoid displaying the error description to the user, it's meant for **debugging** only.
     */
    public var debugDescription: String {
        switch code {
        case let .credentials(error):
            return (error.cause ?? error).localizedDescription
        case let .webAuth(error):
            return (error.cause ?? error).localizedDescription
            
        case let .accessTokenIsNotPresent(message):
            return message
        case let .refreshTokenIsNotPresent(message):
            return message
            
        case let .wrongURL(message):
            return message
        case let .invalidResponse(message):
            return message
            
        case let .notImplemented(message):
            return message
        }
    }
}

extension AuthKitError {
    public enum Code: Equatable {
        // MARK: - Auth0
        case credentials(CredentialsManagerError)
        case webAuth(WebAuthError)
        
        // MARK: - Authentication
        case accessTokenIsNotPresent(String)
        case refreshTokenIsNotPresent(String)
        
        // MARK: - Requests
        case wrongURL(String)
        case invalidResponse(String)
        
        // MARK: - General
        case notImplemented(String)
    }
}
