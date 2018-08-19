//
//  JsonService.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

public class JsonService {
    
    public static func convertToJson(data: Data?) -> Any? {
        guard let data = data else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
    
    public static func convertToData(object: Any?) -> Data? {
        guard let object = object, isValidJson(object: object) else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    }
    
    // MARK: Private helper functions
    private static func isValidJson(object: Any) -> Bool {
        return JSONSerialization.isValidJSONObject(object)
    }
}
