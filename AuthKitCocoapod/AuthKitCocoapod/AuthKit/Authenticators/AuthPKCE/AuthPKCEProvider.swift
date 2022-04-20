//
//  AuthPKCEProvider.swift
//  
//
//  Created by Revel on 2022-03-25.
//

import Foundation

protocol AuthPKCEProvider: AuthProvider, Sendable {
    func requestTokens(clientID: String, codeVerifier: String, authCode: String) async throws -> RequestTokens
}
