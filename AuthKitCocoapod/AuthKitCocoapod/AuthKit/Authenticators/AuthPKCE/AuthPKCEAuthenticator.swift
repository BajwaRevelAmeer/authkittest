//
//  AuthPKCEAuthenticator.swift
//  
//
//  Created by Revel on 2022-03-10.
//

import Foundation
//import AuthKitTypes

struct AuthPKCEAuthenticator {
    let apiManager = APIManager()
}

extension AuthPKCEAuthenticator: AuthPKCEProvider {
    func requestTokens(clientID: String, codeVerifier: String, authCode: String) async throws -> RequestTokens {
        do {
            let request = try apiManager.getPayloadRequestForAPIToken(clientID: clientID, codeVerifier: codeVerifier, authCode: authCode)
            
            guard let requestURL = request.url else {
                throw AuthKitError.init(code: .wrongURL("The string contains characters that are illegal in a URL, or is an empty string"))
            }
            
            let (data, _) = try await URLSession.shared.data(from: requestURL)
            let decoder = JSONDecoder()
            
            return try decoder.decode(RequestTokens.self, from: data)
        } catch {
            throw error
        }
    }
}
