//
//  File.swift
//  
//
//  Created by Ted McGuiggan on 2/11/22.
//

import Foundation
import JWTDecode

protocol ValidatorJWT {
    var issuer: String { get }
    var audience: String { get }

    func validate(_ jwt: JWT, nonce: String?) -> Bool
}
