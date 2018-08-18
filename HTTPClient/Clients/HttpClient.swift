//
//  HTTPClient.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/16/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation


typealias HttpHeaders = [String: String]

private enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class HttpClient {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    var getSession: URLSessionProtocol {
        return session
    }
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    convenience init() {
        self.init(session: URLSession.shared)
    }
    
    //MARK: Public Functions
    func get(url: URL, headers: HttpHeaders?, callback: @escaping completeClosure) {
        submitRequest(url: url, method: .GET, body: nil, headers: headers, callback: callback)
    }
    
    func post(url: URL, body: Data?, headers: HttpHeaders?, callback: @escaping completeClosure) {
        submitRequest(url: url, method: .POST, body: body, headers: headers, callback: callback)
    }
    
    //MARK: Private Functions
    private func submitRequest(url: URL, method: HttpMethod, body: Data?, headers: HttpHeaders?, callback: @escaping completeClosure) {
        let request = createRequest(url: url, method: method, body: body, headers: headers)
        createTaskAndRun(from: request, callback: callback)
    }
    
    // MARK: Fileprivate Functions
    fileprivate func createRequest(url: URL, method: HttpMethod, body: Data?, headers: HttpHeaders?) -> URLRequest {
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
    
    fileprivate func createTaskAndRun(from request: URLRequest, callback: @escaping completeClosure){
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}


