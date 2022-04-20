//
//  APIManager.swift
//  
//
//  Created by Revel on 2022-03-14.
//

import Foundation
import AuthKitTypes

enum Auth0APIRequestType {
    case requestTokens
}

struct APIManager: Sendable {
    
    let bundleIdentifier = Bundle.main.bundleIdentifier!
    let auth0domain = "revelup-dev.auth0.com"
    
    var redirectURL: String {
        "\(bundleIdentifier)://\(auth0domain)/ios/\(bundleIdentifier)/callback"
    }
    
    func getPayloadRequestForAPIToken(
        clientID: String,
        codeVerifier: String,
        authCode: String
    ) throws -> URLRequest {
        let headers = ["content-type": "application/x-www-form-urlencoded"]
        let body = ["grant_type": "authorization_code",
                    "client_id": clientID,
                    "code_verifier": codeVerifier,
                    "code": authCode,
                    "redirect_uri": redirectURL
        ]
        
        let tokenURL = "https://\(auth0domain)/oauth/token"
        
        guard let url = URL(string: tokenURL) else {
            throw AuthKitError(code: .wrongURL("The string contains characters that are illegal in a URL, or is an empty string"))
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10)
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        
        return request
    }
}
