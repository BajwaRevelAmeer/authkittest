//
//  Constants.swift
//  
//
//  Created by Revel on 2022-03-17.
//

import Foundation

struct Constants {}

extension Constants {
    struct Keychain {
        static let domain = "Auth0"
        static let refreshToken = "auth0-refresh-token"
    }
}

extension Constants {
    struct Scope {
        static let offlineAccess = "openid offline_access"
    }
}

extension Constants {
    struct Core {
        static let loggingLabel = "com.authKit.logging"
    }
}
