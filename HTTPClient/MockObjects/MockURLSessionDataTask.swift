//
//  MockURLSessionDataTask.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

public class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    public private(set) var resumeWasCalled = false
    
    public func resume() {
        resumeWasCalled = true
    }
}
