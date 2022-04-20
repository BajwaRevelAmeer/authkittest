//
//  Auth0Authenticator.swift
//  
//
//  Created by Revel on 2022-03-09.
//

import Foundation
import Auth0
import AuthKitTypes

struct Auth0Authenticator {
    
    private let logger: AuthKitLoggingProvider
    private let credentialManager: CredentialsManager
    
    var isAuthenticated: Bool {
        let isAuthenticated = credentialManager.hasValid()
        logger.logInfo("Is authenticated - \(isAuthenticated)")
        
        return isAuthenticated
    }
    
    init(credentialManager: CredentialsManager) {
        self.logger = AppEnvironment.bootstrap().logger
        self.credentialManager = credentialManager
    }
}

// MARK: - Interface
extension Auth0Authenticator: Auth0Provider {
    func authenticate() async throws -> Bool {
        try await webAuth()
    }
    
    func retrieveAccessToken() async throws -> String {
        guard isAuthenticated else {
            logger.logError("Access token is not present, please authenticate",
                            parameters: [
                                "Has valid credentials": "\(isAuthenticated)"
                            ])
            
            throw AuthKitError(code: .accessTokenIsNotPresent("Access token is not present, please authenticate"))
        }
        
        let credentials = try await credentials()
        
        logger.logInfo("Successfully retrieved access token",
                       parameters: [
                        "Expires in": "\(credentials.expiresIn)"
                       ])
        
        return credentials.accessToken
    }
    
    func renewAccessToken() async throws -> String {
        let credentials = try await credentials()
        
        guard let refreshToken = credentials.refreshToken else {
            logger.logError("Refresh token is not present, please authenticate",
                            parameters: ["Expires in": "\(credentials.expiresIn)"])
            throw AuthKitError(code: .refreshTokenIsNotPresent("Refresh token is not present, please authenticate"))
        }
        
        logger.logInfo("Successfully retrieved Refresh token")
        
        return try await renew(with: refreshToken)
    }
    
    func revoke(headers: [String: String] = [:]) async throws {
        try await revokeCredentials(headers: headers)
    }
}

// MARK: - Private Methods / Web Requests
extension Auth0Authenticator {
    @MainActor
    private func webAuth() async throws -> Bool {
        do {
            let webAuth = Auth0.webAuth().scope(Constants.Scope.offlineAccess)
            let credentials = try await webAuth.start()
            let didStore = credentialManager.store(credentials: credentials)
            
            logger.logInfo("Successfully stored credentials")
            
            return didStore
        } catch let webAuthError as WebAuthError {
            let errorCause = (webAuthError.cause ?? webAuthError).localizedDescription
            
            logger.logError("Failed to start Web Auth session",
                            parameters: [
                                "Error description" : "\(webAuthError.localizedDescription)",
                                "Error cause" : "\(errorCause))"
                            ])
            
            throw AuthKitError(code: .webAuth(webAuthError))
        }
    }
    
    private func renew(with refreshToken: String) async throws -> String {
        do {
            let renewal = Auth0.authentication().renew(withRefreshToken: refreshToken)
            let credentials = try await renewal.start()
            
            logger.logInfo("Successfully renewed credentials",
                           parameters: ["Expires in": "\(credentials.expiresIn)"])
            
            return credentials.accessToken
        } catch let webAuthError as WebAuthError {
            let errorCause = (webAuthError.cause ?? webAuthError).localizedDescription
            
            logger.logError("Failed to start renewal session",
                            parameters: [
                                "Error description" : "\(webAuthError.localizedDescription)",
                                "Error cause" : "\(errorCause))"
                            ])
            
            throw AuthKitError(code: .webAuth(webAuthError))
        }
    }
}

// MARK: - Private Methods / Credential Manager
extension Auth0Authenticator {
    private func credentials() async throws -> Credentials {
        do {
            let credentials = try await credentialManager.credentials()
            
            logger.logInfo("Successfully retrieved credentials",
                           parameters: [
                            "Expires in": "\(credentials.expiresIn)"
                           ])
            
            return credentials
        } catch let credentialManagerError as CredentialsManagerError {
            let errorCause = (credentialManagerError.cause ?? credentialManagerError).localizedDescription
            
            logger.logError("Failed to obtains credentials",
                            parameters: [
                                "Error description" : "\(credentialManagerError.localizedDescription)",
                                "Error cause" : "\(errorCause))"
                            ])
            
            throw AuthKitError(code: .credentials(credentialManagerError))
        }
    }
    
    private func revokeCredentials(headers: [String: String] = [:]) async throws {
        do {
            try await credentialManager.revoke(headers: headers)
            
            logger.logInfo("Successfully revoked credentials")
        } catch let credentialManagerError as CredentialsManagerError {
            let errorCause = (credentialManagerError.cause ?? credentialManagerError).localizedDescription
            
            logger.logError("Failed to revoke credentials",
                            parameters: [
                                "Error description" : "\(credentialManagerError.localizedDescription)",
                                "Error cause" : "\(errorCause))"
                            ])
            
            throw AuthKitError(code: .credentials(credentialManagerError))
        }
    }
}
