//
//  HTTPClient.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/16/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

public typealias HttpHeaders = [String: String]

public enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
}

public class HttpClient {
    
    public typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    public var getSession: URLSessionProtocol {
        return session
    }
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public convenience init() {
        self.init(session: URLSession.shared)
    }
    
    //MARK: Public Functions
    public func get(url: URL, headers: HttpHeaders?, callback: @escaping completeClosure) {
        submitRequest(url: url, method: .GET, body: nil, headers: headers, callback: callback)
    }
    
    public func post(url: URL, body: Data?, headers: HttpHeaders?, callback: @escaping completeClosure) {
        submitRequest(url: url, method: .POST, body: body, headers: headers, callback: callback)
    }
    
    //MARK: Private Functions
    private func submitRequest(url: URL, method: HttpMethod, body: Data?, headers: HttpHeaders?, callback: @escaping completeClosure) {
        let request = createRequest(url: url, method: method, body: body, headers: headers)
        createTaskAndRun(from: request, callback: callback)
    }
    
    private func createRequest(url: URL, method: HttpMethod, body: Data?, headers: HttpHeaders?) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request as URLRequest
    }
    
    private func createTaskAndRun(from request: URLRequest, callback: @escaping completeClosure){
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}


