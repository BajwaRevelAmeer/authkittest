//
//  Dictionary+Extension.swift
//  
//
//  Created by Revel on 2022-03-09.
//

import Foundation

extension Dictionary {
    func logAsJSON() -> String? {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
           let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            return theJSONText
        }
        return nil
    }
    
}
