//
//  JsonServiceTests.swift
//  HTTPClientTests
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import XCTest
@testable import HTTPClient

class JsonServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_convert_dict_to_json() {
        //setup
        let key = "data", value = "someData"
        let data = "{\"\(key)\":\"\(value)\"}".data(using: .utf8)
        
        //test
        let json = JsonService.convertToJson(data: data)
        let jsonDict = json as? [String: Any?]
        let jsonValue = jsonDict?[key] as? String
        
        //assert
        XCTAssertNotNil(json)
        XCTAssertNotNil(jsonDict)
        XCTAssertNotNil(jsonValue)
        XCTAssert(jsonValue == value)
    }
    
    func test_convert_arry_to_json() {
        //setup
        let array = ["someData"]
        let data = "\(array)".data(using: .utf8)
        
        //test
        let json = JsonService.convertToJson(data: data)
        let jsonArry = json as? [Any?]
        let jsonValue = jsonArry?[0] as? String
        
        //assert
        XCTAssertNotNil(json)
        XCTAssertNotNil(jsonArry)
        XCTAssert(jsonArry?.count == 1)
        XCTAssertNotNil(jsonValue)
        XCTAssert(jsonValue == array[0])
    }
    
    func test_convert_nil_to_json() {
        //test
        let json = JsonService.convertToJson(data: nil)
        //assert
        XCTAssertNil(json)
    }
    
    func test_convert_invalidJson_to_json() {
        //setup
        let string = "Hello World!"
        let data = string.data(using: .utf8)
        
        //test
        let json = JsonService.convertToJson(data: data)
        
        //assert
        XCTAssertNil(json)
    }
    
    func test_convert_dict_to_data() {
        //setup
        let key = "data", value = "someData"
        let dict = [key: value]
        
        //test
        let data = JsonService.convertToData(object: dict)
        
        let json = JsonService.convertToJson(data: data)
        let jsonDict = json as? [String: Any?]
        let jsonValue = jsonDict?[key] as? String
    
        //assert
        XCTAssertNotNil(data)
        XCTAssertNotNil(json)
        XCTAssertNotNil(jsonDict)
        XCTAssertNotNil(jsonValue)
        XCTAssert(jsonValue == value)
    }
    
    func test_convert_arry_to_data() {
        //setup
        let array = ["someData"]
        
        //test
        let data = JsonService.convertToData(object: array)
        
        let json = JsonService.convertToJson(data: data)
        
        let jsonArry = json as? [Any?]
        let jsonValue = jsonArry?[0] as? String
        
        //assert
        XCTAssertNotNil(data)
        XCTAssertNotNil(json)
        XCTAssertNotNil(jsonArry)
        XCTAssert(jsonArry?.count == 1)
        XCTAssertNotNil(jsonValue)
        XCTAssert(jsonValue == array[0])
    }
    
    func test_convert_nil_to_data() {
        //test
        let data = JsonService.convertToData(object: nil)
        //assert
        XCTAssertNil(data)
    }
    
    func test_invalid_json_to_data() {
        //setup
        let object = "Hello World!"
        //test
        let data = JsonService.convertToData(object: object)
        //assert
        XCTAssertNil(data)
    }
}
