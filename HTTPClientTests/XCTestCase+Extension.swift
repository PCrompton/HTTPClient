//
//  XCTestCase+Extension.swift
//  HTTPClientTests
//
//  Created by Paul Crompton on 8/17/18.
//  Copyright © 2018 Paul Crompton. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func waitForRequest() {
        let timeInterval = TimeInterval(10)
        waitForExpectations(timeout: timeInterval) { (error) in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
    }
}
