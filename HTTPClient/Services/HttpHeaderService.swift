//
//  HttpHeaderTypes.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

enum HttpHeaderKeys: String {
    case contentType = "Content-Type"
}

enum HttpContentTypes: String {
    case applicationJson = "application/json"
}

class HttpHeaderService {

    static func setContentType(for headers: HttpHeaders?, with value: String) -> HttpHeaders {
        var mutableHeaders = headers
        if headers == nil {
            mutableHeaders = HttpHeaders()
        }
        mutableHeaders![HttpHeaderKeys.contentType.rawValue] = value
        return mutableHeaders!
    }
}
