//
//  JSONClient.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

class JsonClient {
    typealias completeClosure = (_ jsonData: Any?, _ error: Error?) -> Void
    
    var httpClient: HttpClient
    var getHttpClient: HttpClient {
        return httpClient
    }
    init(session: URLSessionProtocol) {
        self.httpClient = HttpClient(session: session)
    }
    
    convenience init() {
        self.init(session: URLSession.shared)
    }
    
    // MARK: Public Functions
    func get(url: URL, headers: HttpHeaders?, callback: @escaping completeClosure) {
        httpClient.get(url: url, headers: HttpHeaderService.setContentType(for: headers, with: HttpContentTypes.applicationJson.rawValue)) { (data, error) in
            let jsonData = JsonService.convertToJson(data: data)
            callback(jsonData, error)
        }
    }
    
    func post(url: URL, body: Any?, headers: HttpHeaders?, callback: @escaping completeClosure) {
        httpClient.post(url: url, body: JsonService.convertToData(object: body), headers: HttpHeaderService.setContentType(for: headers, with: HttpContentTypes.applicationJson.rawValue)) { (data, error) in
            let jsonData = JsonService.convertToJson(data: data)
            callback(jsonData, error)
        }
    }
}
