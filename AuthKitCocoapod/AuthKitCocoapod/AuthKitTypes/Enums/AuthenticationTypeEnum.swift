//
//  AuthenticationType.swift
//  
//
//  Created by Revel on 2022-03-09.
//

import Foundation

/// This enum represents the authentication type used for the Auth0 process
public enum AuthenticationType {
    /// A type used for the already provisioned customers.
    case standard
    /// A type used for the initial provisioning of the new customers.
    case provision
}

extension AuthenticationType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .standard:
            return "Standard flow"
        case .provision:
            return "Provisioning flow"
        }
    }
}
