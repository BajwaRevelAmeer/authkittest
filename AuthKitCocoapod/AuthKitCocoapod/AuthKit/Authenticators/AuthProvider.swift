//
//  AuthProvider.swift
//  
//
//  Created by Revel on 2022-03-10.
//

import Foundation
import AuthKitTypes

protocol AuthProvider {
    var isAuthenticated: Bool { get throws }
    
    func authenticate() async throws -> Bool
    func retrieveAccessToken() async throws -> String
    func renewAccessToken() async throws -> String
    func revoke() async throws
}

extension AuthProvider {
    var isAuthenticated: Bool {
        get throws {
            throw AuthKitError(code: .notImplemented("\(#function) is not implemented"))
        }
    }
    
    func authenticate() async throws -> Bool {
        throw AuthKitError(code: .notImplemented("\(#function) is not implemented"))
    }
    
    func retrieveAccessToken() async throws -> String {
        throw AuthKitError(code: .notImplemented("\(#function) is not implemented"))
    }
    
    func renewAccessToken() async throws -> String {
        throw AuthKitError(code: .notImplemented("\(#function) is not implemented"))
    }
    
    func revoke() async throws {
        throw AuthKitError(code: .notImplemented("\(#function) is not implemented"))
    }
}
