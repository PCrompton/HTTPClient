//
//  JSONClientTests.swift
//  HTTPClientTests
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import XCTest
import Foundation
@testable import HTTPClient

class JsonClientTests: XCTestCase {
    
    var jsonClient: JsonClient!
    var url = URL(string: "https://mockurl")!
    var headersContentTypeJson = [HttpHeaderKeys.contentType.rawValue: HttpContentTypes.applicationJson.rawValue]
    var headersContentTypeNotJson = [HttpHeaderKeys.contentType.rawValue: "notJson"]
    var bodyDict = ["data": "dateToSubmit"]
    var bodyArry = ["someData"]

    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        jsonClient = JsonClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: Tests
    
    //JsonClient.convenience init()
    func test_convenience_init() {
        let jsonClient = JsonClient()
        let httpClient = jsonClient.getHttpClient
        let urlSession = httpClient.getSession as? URLSession
        
        XCTAssertNotNil(httpClient)
        XCTAssertNotNil(urlSession)
        XCTAssert(urlSession == URLSession.shared)
    }
    
    //MARK: JsonClient.get()
    
    //Returning dict
    func test_get_withURL_noHeaders_returningDict() {
        get_returningDict(url: url, headers: nil)
    }
    
    func test_get_withURL_contentTypeJson_returningDict() {
        get_returningDict(url: url, headers: headersContentTypeJson)
    }
    
    func test_get_withURL_contentTypeNotJson_returningDict() {
        get_returningDict(url: url, headers: headersContentTypeNotJson)
    }
    
    //Returning array
    func test_get_withURL_noHeaders_returningArray() {
        get_returningArry(url: url, headers: nil)
    }
    
    func test_get_withURL_contentTypeJson_returningArray() {
        get_returningArry(url: url, headers: headersContentTypeJson)
    }
    
    func test_get_withURL_contentTypeNotJson_returningArray() {
        get_returningArry(url: url, headers: headersContentTypeNotJson)
    }

    //MARK: JsonClient.post()
    
    //with dict body returning dict
    func test_post_withURL_withDictBody_noHeaders_returning_dict() {
        post_returningDict(url: url, body: bodyDict, headers: nil)
    }
    func test_post_withURL_withDictBody_contentTypeJson_returning_dict() {
        post_returningDict(url: url, body: bodyDict, headers: headersContentTypeJson)
    }
    func test_post_withURL_withDictBody_contentTypeNotJson_returning_dict() {
        post_returningDict(url: url, body: bodyDict, headers: headersContentTypeNotJson)
    }
    
    //with array body returning dict
    func test_post_withURL_withArryBody_noHeaders_returning_dict() {
        post_returningDict(url: url, body: bodyArry, headers: nil)
    }
    func test_post_withURL_withArryBody_contentTypeJson_returning_dict() {
        post_returningDict(url: url, body: bodyArry, headers: headersContentTypeJson)
    }
    func test_post_withURL_withArryBody_contentTypeNotJson_returning_dict() {
        post_returningDict(url: url, body: bodyArry, headers: headersContentTypeNotJson)
    }
    
    //with dict body returning array
    func test_post_withURL_withDictBody_noHeaders_returning_array() {
        post_returningArry(url: url, body: bodyDict, headers: nil)
    }
    func test_post_withURL_withDictBody_contentTypeJson_returning_array() {
        post_returningArry(url: url, body: bodyDict, headers: headersContentTypeJson)
    }
    func test_post_withURL_withDictBody_contentTypeNotJson_returning_array() {
        post_returningArry(url: url, body: bodyDict, headers: headersContentTypeNotJson)
    }

    //with array body returning array
    func test_post_withURL_withArryBody_noHeaders_returning_array() {
        post_returningArry(url: url, body: bodyArry, headers: nil)
    }
    func test_post_withURL_withArryBody_contentTypeJson_returning_array() {
        post_returningArry(url: url, body: bodyArry, headers: headersContentTypeJson)
    }
    func test_post_withURL_withArryBody_contentTypeNotJson_returning_array() {
        post_returningArry(url: url, body: bodyArry, headers: headersContentTypeNotJson)
    }
    
    //MARK: Reusable Test Funcs
    
    private func get_returningDict(url: URL, headers: HttpHeaders?) {
        let expect = expectation(description: "get completetion called and return data")
        
        let key = "data", value = "someData"
        let dataString = "{\"\(key)\": \"\(value)\"}"
        self.session.nextData = dataString.data(using: .utf8)
        self.session.nextError = nil
        
        get(url: url, headers: headers) { (jsonData, error) in
            XCTAssertNotNil(jsonData)
            XCTAssertNil(error)
            
            XCTAssertNotNil(jsonData as? [String: Any])
            
            if let jsonDict = jsonData as? [String: Any] {
                XCTAssertNotNil(jsonDict[key] as? String)
                XCTAssert(jsonDict[key] as! String == value)
            }
            expect.fulfill()
        }
        waitForRequest()
    }
    
    private func get_returningArry(url: URL, headers: HttpHeaders?) {
        let expect = expectation(description: "get completion called and return array")
        let dataValue = "someData"
        let dataString = "[\"\(dataValue)\"]"
        self.session.nextData = dataString.data(using: .utf8)
        self.session.nextError = nil
        
        get(url: url, headers: headers) { (jsonData, error) in
            XCTAssertNotNil(jsonData)
            XCTAssertNil(error)
            
            XCTAssertNotNil(jsonData as? [Any?])
            
            if let jsonArray = jsonData as? [Any?] {
                XCTAssert(jsonArray.count == 1)
                XCTAssertNotNil(jsonArray[0] as? String)
                XCTAssert(jsonArray[0] as! String == dataValue)
            }
            expect.fulfill()
        }
        waitForRequest()
    }

    private func get(url: URL, headers: HttpHeaders?, callback: @escaping JsonClient.completeClosure) {
        jsonClient.get(url: url, headers: nil, callback: callback)
        XCTAssert(session.dataTaskCalled)
        
        XCTAssert(session.lastHttpHeaders == [HttpHeaderKeys.contentType.rawValue: HttpContentTypes.applicationJson.rawValue])
        let adjustedLastHeaders = NSMutableDictionary(dictionary: session.lastHttpHeaders!)
        adjustedLastHeaders.removeObject(forKey: HttpHeaderKeys.contentType.rawValue)
        if let headers = headers {
            let adjustedHeaders = NSMutableDictionary(dictionary: headers)
            adjustedHeaders.removeObject(forKey: HttpHeaderKeys.contentType.rawValue)
            XCTAssert(adjustedHeaders == adjustedLastHeaders)
        } else {
            XCTAssert(adjustedLastHeaders.count == 0)
        }
    }
    
    private func post_returningDict(url: URL, body: Any?, headers: HttpHeaders?) {
        let expect = expectation(description: "post completion called and returns dict")
        let key = "data", value = "someData"
        let dataString = "{\"\(key)\": \"\(value)\"}"
        session.nextData = dataString.data(using: .utf8)
        session.nextError = nil
        
        post(url: url, body: body, headers: headers) { (jsonData, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(jsonData)
            
            XCTAssertNotNil(jsonData as? [String: Any])
            
            if let jsonDict = jsonData as? [String: Any] {
                XCTAssertNotNil(jsonDict["data"] as? String)
                XCTAssert(jsonDict["data"] as! String == "someData")
            }
            expect.fulfill()
        }
        waitForRequest()
    }
    
    private func post_returningArry(url: URL, body: Any?, headers: HttpHeaders?) {
        let expect = expectation(description: "post complection called and returns array")
        let dataValue = "someData"
        let dataString = "[\"\(dataValue)\"]"
        session.nextData = dataString.data(using: .utf8)
        session.nextError = nil
        
        post(url: url, body: body, headers: headers) { (jsonData, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(jsonData)
            
            XCTAssertNotNil(jsonData as? [Any?])
            
            if let jsonArray = jsonData as? [Any?] {
                XCTAssert(jsonArray.count == 1)
                XCTAssertNotNil(jsonArray[0] as? String)
                XCTAssert(jsonArray[0] as! String == dataValue)
            }
            expect.fulfill()
        }
        waitForRequest()
    }
    
    private func post(url: URL, body: Any?, headers: HttpHeaders?, callback: @escaping JsonClient.completeClosure ) {
        
        jsonClient.post(url: url, body: body, headers: nil, callback: callback)
        
        let jsonLastBody = JsonService.convertToJson(data: session.lastBody)
        
        XCTAssert(session.dataTaskCalled)
        XCTAssert(session.lastHttpHeaders == [HttpHeaderKeys.contentType.rawValue: HttpContentTypes.applicationJson.rawValue])
        XCTAssert(jsonLastBody as? [String] != nil || jsonLastBody as? [String:String] != nil)
        if let lastBodyDict = jsonLastBody as? [String:String] {
            XCTAssert(bodyDict == lastBodyDict)
        }
        if let lastBodyArry = jsonLastBody as? [String] {
            XCTAssert(bodyArry == lastBodyArry)
        }
    }
}
