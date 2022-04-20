//
//  URL+Extension.swift
//  
//
//  Created by Revel on 2022-03-09.
//

import Foundation

extension URL {
    func getQueryStringParameter(_ parameter: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        
        return url.queryItems?.first(where: { $0.name == parameter })?.value
    }
}
