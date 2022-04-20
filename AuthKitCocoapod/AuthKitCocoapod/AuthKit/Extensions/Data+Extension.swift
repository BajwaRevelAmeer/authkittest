//
//  Data+Extension.swift
//  
//
//  Created by Revel on 2022-03-09.
//

import Foundation

extension Data {
    func logAsJSON() -> String? {
        if let theJSONData = try? JSONSerialization.jsonObject(with: self, options: []) as? NSDictionary {
            var swiftDict: [String: Any] = [:]
            for key in theJSONData.allKeys {
                let stringKey = key as? String
                if let key = stringKey, let keyValue = theJSONData.value(forKey: key) {
                    swiftDict[key] = keyValue
                }
            }
            return swiftDict.logAsJSON()
        }
        return nil
    }
}
