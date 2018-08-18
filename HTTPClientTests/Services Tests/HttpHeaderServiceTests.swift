//
//  HttpHeaderServiceTests.swift
//  HTTPClientTests
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import XCTest
@testable import HTTPClient

class HttpHeaderServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_set_content_type() {
        
        let key1 = "key1"
        let key2 = "key2"
        let value1 = "value1"
        let value2 = "value2"
        
        let headers = [
            key1: value1,
            key2: value2
        ]
        
        var newHeaders = HttpHeaderService.setContentType(for: headers, with: HttpContentTypes.applicationJson.rawValue)
        
        XCTAssert(newHeaders.count == headers.count + 1)
        XCTAssert(newHeaders[HttpHeaderKeys.contentType.rawValue] == HttpContentTypes.applicationJson.rawValue)
        XCTAssert(newHeaders[key1] == value1)
        XCTAssert(newHeaders[key2] == value2)
    }
    
    func test_set_content_type_headers_nil() {

        var headers = HttpHeaderService.setContentType(for: nil, with: HttpContentTypes.applicationJson.rawValue)
        
        XCTAssert(headers.count == 1)
        XCTAssert(headers[HttpHeaderKeys.contentType.rawValue] == HttpContentTypes.applicationJson.rawValue)
    }
}
