//
//  Auth0Provider.swift
//  
//
//  Created by Revel on 2022-03-25.
//

import Foundation

protocol Auth0Provider: AuthProvider {    
    func revoke(headers: [String: String]) async throws
}
