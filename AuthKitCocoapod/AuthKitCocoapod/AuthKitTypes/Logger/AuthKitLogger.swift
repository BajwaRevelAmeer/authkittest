//
//  AuthKitLogger.swift
//  
//
//  Created by Revel on 2022-03-28.
//

import Foundation

public enum AuthKitLoggerType: String {
    case error
    case warning
    case info
}

public protocol AuthKitLoggingProvider {
    func log(message: String,
             parameters: [String: String],
             type: AuthKitLoggerType)
}
