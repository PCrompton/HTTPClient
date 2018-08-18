//
//  JsonService.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

class JsonService {
    
    static func convertToJson(data: Data?) -> Any? {
        if let data = data {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            } catch {
                return nil
            }
        }
        return nil
    }
    
    static func convertToData(object: Any?) -> Data? {
        if let object = object {
            if JSONSerialization.isValidJSONObject(object) {
                return try! JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            }
        }
        return nil
    }
}
