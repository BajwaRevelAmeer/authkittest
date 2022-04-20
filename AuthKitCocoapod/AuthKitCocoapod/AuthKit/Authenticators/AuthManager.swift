//
//  AuthManager.swift
//  
//
//  Created by Revel on 2022-03-09.
//

import Foundation
//import AuthKitTypes
import struct Auth0.CredentialsManager

struct AuthManager: AuthManagerProvider {
    
    private let logger: AuthKitLoggingProvider
    private let auth0Authenticator: Auth0Provider
    private let authPKCEAuthenticator: AuthPKCEProvider
    
    init(auth0Authenticator: Auth0Provider, authPKCEAuthenticator: AuthPKCEProvider) {
        self.logger = AppEnvironment.bootstrap().logger
        self.auth0Authenticator = auth0Authenticator
        self.authPKCEAuthenticator = authPKCEAuthenticator
    }
}

// MARK: - AuthManager / Interface
extension AuthManager {
    func isAuthenticated(using type: AuthenticationType) throws -> Bool {
        logger.logInfo("Performing is authenticated check of type: \(type.description)")
        
        switch type {
        case .standard:
            return try auth0Authenticator.isAuthenticated
        case .provision:
            return try authPKCEAuthenticator.isAuthenticated
        }
    }
    
    func authenticate(using type: AuthenticationType) async throws -> Bool {
        logger.logInfo("Performing authentication of type: \(type.description)")
        
        switch type {
        case .standard:
            return try await auth0Authenticator.authenticate()
        case .provision:
            return try await authPKCEAuthenticator.authenticate()
        }
    }
    
    func retrieveAccessToken(using type: AuthenticationType) async throws -> String {
        logger.logInfo("Performing access token retrieval of type: \(type.description)")
        
        switch type {
        case .standard:
            return try await auth0Authenticator.retrieveAccessToken()
        case .provision:
            return try await authPKCEAuthenticator.retrieveAccessToken()
        }
    }
    
    func renewAccessToken(using type: AuthenticationType) async throws -> String {
        logger.logInfo("Performing access token renewal of type: \(type.description)")
        
        switch type {
        case .standard:
            return try await auth0Authenticator.renewAccessToken()
        case .provision:
            return try await authPKCEAuthenticator.renewAccessToken()
        }
    }
    
    func revoke(
        using type: AuthenticationType,
        headers: [String: String]?
    ) async throws {
        logger.logInfo("Performing access token revoke of type: \(type.description)")
        
        switch type {
        case .standard:
            try await auth0Authenticator.revoke(headers: headers ?? [:])
        case .provision:
            try await authPKCEAuthenticator.revoke()
        }
    }
    
    func requestAccessTokens(
        clientID: String,
        codeVerifier: String,
        authCode: String
    ) async throws -> RequestTokens {
        try await authPKCEAuthenticator.requestTokens(
            clientID: clientID,
            codeVerifier: codeVerifier,
            authCode: authCode
        )
    }
}

