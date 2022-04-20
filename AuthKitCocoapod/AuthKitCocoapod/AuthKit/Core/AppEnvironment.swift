//
//  AppEnvironment.swift
//  
//
//  Created by Revel on 2022-03-28.
//

import Foundation
//import AuthKitTypes

struct AppEnvironment {
    
    let logger: AuthKitLoggingProvider
    
    init(logger: AuthKitLoggingProvider) {
        self.logger = logger
    }
}

extension AppEnvironment {
    
    static private var current: AppEnvironment?
    
    /**
     Sets current environment
     - Parameter environment: An app environment used in the AuthKit
     */
    static func set(_ environment: AppEnvironment) {
        AppEnvironment.current = environment
    }
    
    /**
     A bootstrap environment set for the AuthKit.
     
     *Note*
     
     The AppEnvironment must specified before accessing this method -otherwise, fatalError.
     */
    static func bootstrap() -> AppEnvironment {
        guard let environment = AppEnvironment.current else {
            fatalError("Environment not set. Please set current environment.")
        }
        
        return environment
    }
}
