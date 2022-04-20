//
//  File 2.swift
//  
//
//  Created by Ted McGuiggan on 2/11/22.
//

import Foundation
import JWTDecode

/// IDTokenValidation will validate claims
public struct IDTokenValidation: ValidatorJWT {
    /// `iss` claim value
    public let issuer: String

    /// `aud` claim value
    public let audience: String

    /// Initialiser
    ///
    /// - Parameters:
    ///   - issuer: Value to validate the `iss` claim against
    ///   - audience: Value to validate the `aud` claim against
    public init(issuer: String, audience: String) {
        self.issuer = issuer
        self.audience = audience
    }
    
    /// Validate a JWT
    ///
    /// - Parameters:
    ///   - jwt: The JWT to validate
    ///   - nonce: (Optional) nonce value
    /// - Returns: Success status
    public func validate(_ jwt: JWT, nonce: String? = nil) -> Bool {
        guard let jwtAudience = jwt.audience else { return false }
        if issuer != jwt.issuer { return false }
        if !jwtAudience.contains(audience) { return false }
        if jwt.expired { return false }
        if let jwtNonce = jwt.claim(name: "nonce").string {
            guard let nonce = nonce, nonce == jwtNonce else { return false }
        }
        return true
    }
}
