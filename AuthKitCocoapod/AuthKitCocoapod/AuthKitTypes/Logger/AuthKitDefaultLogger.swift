//
//  AuthKitDefaultLogger.swift
//  
//
//  Created by Revel on 2022-03-28.
//

import Foundation

public final class AuthKitDefaultLogger: AuthKitLoggingProvider {
    
    public init() { }
    
    public func log(message: String, parameters: [String : String], type: AuthKitLoggerType) {
        let prefix = "[AuthKit] \(type): "
        let parameters = parameters
            .map { " " + $0.0 + " = " + $0.1 }
            .joined(separator: ";")
        let formattedMessage = prefix + message + ";" + parameters
        
        print(formattedMessage)
    }
}
