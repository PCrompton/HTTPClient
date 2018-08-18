//
//  MockURLSessionDataTask.swift
//  HTTPClient
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
