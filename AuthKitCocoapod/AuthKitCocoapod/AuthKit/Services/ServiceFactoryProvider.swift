//
//  ServiceFactoryProvider.swift
//  
//
//  Created by Revel on 2022-03-28.
//

import Foundation

protocol ServiceFactoryProvider {
    var authManager: AuthManagerProvider { get }
}
