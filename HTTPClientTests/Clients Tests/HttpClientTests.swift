//
//  HTTPClientTests.swift
//  HTTPClientTests
//
//  Created by Paul Crompton on 8/16/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import XCTest
@testable import HTTPClient

class HttpClientTests: XCTestCase {
    
    var httpClient: HttpClient!
    var url = URL(string: "https://mockurl")!
    var headers = [HttpHeaderKeys.contentType.rawValue: HttpContentTypes.applicationJson.rawValue]
    var body: Data? {
        let dataString = "{data:\"someData\"}"
        return dataString.data(using: .utf8)
    }
    
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //Mark: Tests
    
    //HttpClient.convenience init()
    func test_convenience_init() {
        let httpClient = HttpClient()
        XCTAssert(httpClient.getSession as? URLSession === URLSession.shared)
    }
    
    //HttpClient.get()
    func test_get_withURL_and_headers() {
        get(url: url, headers: headers)
    }
    
    func test_get_withURL_no_headers() {
        get(url: url, headers: nil)
    }
    
    //HttpClient.post()
    func test_post_withURL_withBody_withHeaders() {
        post(url: url, body: body, headers: headers)
    }
    
    func test_post_withURL_noBody_noHeaders() {
        post(url: url, body: nil, headers: nil)
    }
    
    func test_post_withURL_withBody_noHeaders() {
        post(url: url, body: body, headers: nil)
    }
    
    func test_post_withURL_noBody_withHeaders() {
        post(url: url, body: nil, headers: headers)
    }
        
    //MARK: Reusable Test Funcs
    
    private func get(url: URL, headers: HttpHeaders?) {
        let expect = expectation(description: "get completion called and return data")
        let dataValue = "someData"
        session.nextData = dataValue.data(using: .utf8)
        session.nextError = nil
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        httpClient.get(url: url, headers: headers) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssert(String(data: data!, encoding: String.Encoding.ascii) == dataValue)
            expect.fulfill()
        }
        XCTAssert(session.lastURL == url)
        XCTAssert(dataTask.resumeWasCalled)
        XCTAssert(session.lastHttpHeaders == headers)
        XCTAssert(session.lastMethod == "GET")
        XCTAssert(session.lastBody == nil)
        waitForRequest()
    }
    
    private func post(url: URL, body: Data?, headers: HttpHeaders?) {
        let expect = expectation(description: "post completion called and return data")
        let dataValue = "someData"
        session.nextData = dataValue.data(using: .utf8)
        session.nextError = nil
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        httpClient.post(url: url, body: body, headers: headers) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssert(String(data: data!, encoding: String.Encoding.ascii) == dataValue)
            expect.fulfill()
        }
        XCTAssert(session.lastURL == url)
        XCTAssert(dataTask.resumeWasCalled)
        XCTAssert(session.lastHttpHeaders == headers)
        XCTAssert(session.lastBody == body)
        XCTAssert(session.lastMethod == "POST")
        waitForRequest()
    }
}
