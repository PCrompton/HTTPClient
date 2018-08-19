//
//  MockURLSession.swift
//  HTTPClientTests
//
//  Created by Paul Crompton on 8/16/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

public class MockURLSession: URLSessionProtocol {
    
    public var nextDataTask = MockURLSessionDataTask()
    public var nextData: Data?
    public var nextError: Error?
    
    public private(set) var dataTaskCalled: Bool = false
    public private(set) var lastURL: URL?
    public private(set) var lastBody: Data?
    public private(set) var lastMethod: String?
    public private(set) var lastHttpHeaders: HttpHeaders?
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        dataTaskCalled = true
        lastURL = request.url
        lastBody = request.httpBody
        lastMethod = request.httpMethod
        let allHttpHeaderFields = request.allHTTPHeaderFields
        if let allHttpHeaderFields = allHttpHeaderFields {
            if allHttpHeaderFields.count > 0 {
                lastHttpHeaders = request.allHTTPHeaderFields
            }
        }
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
    
    //MARK: Private Functions
    private func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
}
