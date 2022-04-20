//
//  ServicesFactory.swift
//  
//
//  Created by Revel on 2022-03-28.
//

import Foundation
import AuthKitTypes
import Auth0

actor ServiceFactory: ServiceFactoryProvider {
    
    let authManager: AuthManagerProvider
    
    init(logger: AuthKitLoggingProvider, bundle: Bundle) {
        AppEnvironment.set(AppEnvironment(logger: logger))
        
        let authentication = Auth0.authentication(session: .shared, bundle: bundle)
        let credentialManager = CredentialsManager(authentication: authentication)
        
        let auth0Authenticator = Auth0Authenticator(credentialManager: credentialManager)
        let authPCKEAuthenticator = AuthPKCEAuthenticator()
        
        self.authManager = AuthManager(auth0Authenticator: auth0Authenticator, authPKCEAuthenticator: authPCKEAuthenticator)
    }
    
    init(logger: AuthKitLoggingProvider, clientId: String, domain: String) {
        AppEnvironment.set(AppEnvironment(logger: logger))
        
        let authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialManager = CredentialsManager(authentication: authentication)
        
        let auth0Authenticator = Auth0Authenticator(credentialManager: credentialManager)
        let authPCKEAuthenticator = AuthPKCEAuthenticator()
        
        self.authManager = AuthManager(auth0Authenticator: auth0Authenticator, authPKCEAuthenticator: authPCKEAuthenticator)
    }
}
