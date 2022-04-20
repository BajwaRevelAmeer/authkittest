//
//  RequestTokens.swift
//  
//
//  Created by Revel on 2022-03-14.
//

import Foundation

struct RequestTokens: Codable {
    let accessToken, refreshToken, idToken, tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case idToken = "id_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
