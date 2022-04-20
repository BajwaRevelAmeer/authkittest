//
//  AuthKit.swift
//
//
//  Created by Ted McGuiggan on 2/11/22.
//

import Foundation
import AuthKitTypes

public actor AuthKit: AuthKitProvider {
    
    private let servicesFactory: ServiceFactoryProvider
    
    
    /**
     AuthKit initializer that relies on Auth0.plist file.
     
     *Important*
     
     Calling this method without a valid `Auth0.plist` file will crash your application.
     
     - Parameters:
        - logger: logger that logs lifecycle events.
        - bundle: bundle used to locate the `Auth0.plist` file. Defaults to `Bundle.main`.
     */
    public init(
        logger: AuthKitLoggingProvider = AuthKitDefaultLogger(),
        bundle: Bundle = .main
    ) {
        self.servicesFactory = ServiceFactory(logger: logger, bundle: bundle)
    }
    
    /**
     AuthKit initializer that relies on client ID and domain.
     
     - Parameters:
        - logger: logger that logs lifecycle events.
        - clientId: client ID of your Auth0 application.
        - domain: domain of your Auth0 account.
     */
    public init(
        logger: AuthKitLoggingProvider,
        clientId: String,
        domain: String
    ) {
        self.servicesFactory = ServiceFactory(logger: logger, clientId: clientId, domain: domain)
    }
    
    init(servicesFactory: ServiceFactoryProvider) {
        self.servicesFactory = servicesFactory
    }
}

// MARK: - Public Interface / Methods
extension AuthKit {
    nonisolated public func isAuthenticated(using type: AuthenticationType) throws -> Bool {
        return try servicesFactory.authManager.isAuthenticated(using: type)
    }
    
    public func authenticate(using type: AuthenticationType) async throws -> Bool {
        return try await servicesFactory.authManager.authenticate(using: type)
    }
    
    public func retrieveAccessToken(using type: AuthenticationType) async throws -> String {
        return try await servicesFactory.authManager.retrieveAccessToken(using: type)
    }
    
    public func renewAccessToken(using type: AuthenticationType) async throws -> String {
        return try await servicesFactory.authManager.renewAccessToken(using: type)
    }
    
    public func revoke(
        using type: AuthenticationType,
        headers: [String: String]?
    ) async throws {
        try await servicesFactory.authManager.revoke(using: type, headers: headers)
    }
}
