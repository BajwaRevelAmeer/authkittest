//
//  AuthKitProvider.swift
//  
//
//  Created by Revel on 2022-03-25.
//

import Foundation

public protocol AuthKitProvider {
    /**
     Indicates if the credentials are stored, and that the Access Token has not expired and will not expire within the specified TTL (lifetime).
     
     Type:
     * standard - a type used for the already provisioned customers.
     * provision - a type used for the initial provisioning of the new customers.
     
     *Note*
     
     This method depends on the initial authentication type (as of 03/25/22).
     
     The *nonisolated* indicates that this variable can be called externally (can be referenced from a non-isolated context) without using await.
     
     - Returns: If the credentials are stored.
     - Throws: An error of type: `AuthKitError`.
     - parameters:
        - type: authentication type used for the Auth0 process.
     */
    nonisolated func isAuthenticated(using type: AuthenticationType) throws -> Bool
    
    /**
     Authenticates user with one of the authentication methods.
     
     Type:
     * standard - authenticates using Auth0 client using web-based authentication with Universal Login.
     * provision - authenticates using PKCE flow.
     
     
     - Returns: If the credentials were stored.
     - Throws: An error of type: `AuthKitError` that contains `WebAuthError`.
     - parameters:
        - type: authentication type used for the Auth0 process.
     */
    func authenticate(using type: AuthenticationType) async throws -> Bool
    
    /**
     Retrieves access token with one of the authentication methods.

     Type:
     * standard - a type used for the already provisioned customers.
     * provision - a type used for the initial provisioning of the new customers.
     
     *Note*
     
     This method depends on the initial authentication type (as of 03/25/22).
     
     - Returns: An access token.
     - Throws: An error of type: `AuthKitError` that contains `CredentialsManagerError`.
      - parameters:
        - type: authentication type used for the Auth0 process.
     */
    func retrieveAccessToken(using type: AuthenticationType) async throws -> String
    
    /**
     Renews access token with one of the authentication methods.

     Type:
     * standard - a type used for the already provisioned customers.
     * provision - a type used for the initial provisioning of the new customers.
     
     *Note*
     
     This method depends on the initial authentication type (as of 03/25/22).
     
     - Returns: A renewed access token.
     - Throws: An error of type: `AuthKitError` that contains `WebAuthError`.
     - parameters:
        - type: authentication type used for the Auth0 process.
     */
    func renewAccessToken(using type: AuthenticationType) async throws -> String
    
    /**
     Revokes the Refresh Token and then clears the credentials if the request was successful. Otherwise, an error is thrown.
     
     Type:
     * standard - a type used for the already provisioned customers.
     * provision - a type used for the initial provisioning of the new customers.
     
     *Note*
     
     This method depends on the initial authentication type (as of 03/25/22).
     
     - Throws: An error of type: `AuthKitError` that contains `CredentialsManagerError`.
     - parameters:
        - headers: additional headers to use when revoking the Refresh Token.
     */
    
    func revoke(using: AuthenticationType, headers: [String: String]?) async throws
}
