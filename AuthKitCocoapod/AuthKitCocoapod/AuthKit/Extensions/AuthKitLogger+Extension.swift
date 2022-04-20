//
//  AuthKitLogger+Extension.swift
//  
//
//  Created by Revel on 2022-03-30.
//

//import AuthKitTypes

extension AuthKitLoggingProvider {
    func logInfo(_ message: String,
                 parameters: [String: String] = [:]) {
        log(message: message, parameters: parameters, type: .info)
    }
    
    func logWarning(_ message: String,
                    parameters: [String: String] = [:]) {
        log(message: message, parameters: parameters, type: .warning)
    }
    func logError(_ message: String,
                  parameters: [String: String] = [:]) {
        log(message: message, parameters: parameters, type: .error)
    }
}
