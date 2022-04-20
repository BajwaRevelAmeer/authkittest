//
//  AuthManagerProvider.swift
//  
//
//  Created by Revel on 2022-03-31.
//

import AuthKitTypes

protocol AuthManagerProvider {
    func isAuthenticated(using type: AuthenticationType) throws -> Bool
    func authenticate(using type: AuthenticationType) async throws -> Bool
    func retrieveAccessToken(using type: AuthenticationType) async throws -> String
    func renewAccessToken(using type: AuthenticationType) async throws -> String
    func revoke(using type: AuthenticationType, headers: [String: String]?) async throws
    
    // MARK: - PKCE Flow
    func requestAccessTokens(clientID: String, codeVerifier: String, authCode: String) async throws -> RequestTokens
}
