//
//  URLRequest+Extension.swift
//  
//
//  Created by Revel on 2022-03-09.
//

import Foundation

extension URLRequest {
    func log() {
        print("\(httpMethod ?? "") \(self)")
        if let httpBody = httpBody {
            print("Body: \n \(String(describing: String(data: httpBody, encoding: .utf8)))")
        }
        print("Headers: \n \(String(describing: allHTTPHeaderFields))")
    }
}
