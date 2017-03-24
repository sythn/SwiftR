//
//  ValueTests.swift
//  SwiftR
//
//  Created by Seyithan Teymur on 24/03/2017.
//  Copyright © 2017 Brokoli. All rights reserved.
//

import XCTest
@testable import SwiftRKit

class ValueTests: XCTestCase {
    
    let stringValue = SwiftRValue.string("Testing")
    let doubleValue = SwiftRValue.numeric(10)
    let logicalValue = SwiftRValue.logical(true)
    
    override func setUp() {
        super.setUp()
    }
    
    func testValues() {
        if case .string(let value) = stringValue {
            XCTAssertEqual(value, "Testing")
        } else {
            XCTFail()
        }
        
        if case .numeric(let value) = doubleValue {
            XCTAssertEqual(value, 10)
        } else {
            XCTFail()
        }
        
        if case .logical(let value) = logicalValue {
            XCTAssertEqual(value, true)
        } else {
            XCTFail()
        }
    }
    
    func testRawValueType() {
        XCTAssertTrue(stringValue.rawValue is String)
        XCTAssertTrue(doubleValue.rawValue is Double)
        XCTAssertTrue(logicalValue.rawValue is Bool)
    }
    
    func testInitWithRawValue() {
        XCTAssertEqual(stringValue, SwiftRValue(rawValue: "Testing"))
        XCTAssertEqual(doubleValue, SwiftRValue(rawValue: 10))
        XCTAssertEqual(logicalValue, SwiftRValue(rawValue: true))
    }
    
    func testInitFromLiterals() {
        XCTAssertEqual(stringValue, "Testing")
        XCTAssertEqual(doubleValue, 10)
        XCTAssertEqual(doubleValue, 10.0)
        XCTAssertEqual(logicalValue, true)
    }
    
    func testComparing() {
        XCTAssertTrue(SwiftRValue(true) < SwiftRValue(false))
        XCTAssertTrue(SwiftRValue(false) < SwiftRValue(5))
        XCTAssertTrue(SwiftRValue(5) < SwiftRValue(10))
        XCTAssertTrue(SwiftRValue(10) < SwiftRValue("a"))
        XCTAssertTrue(SwiftRValue("a") < SwiftRValue("b"))
        XCTAssertTrue(SwiftRValue(false) < SwiftRValue("a"))
        XCTAssertTrue(SwiftRValue(true) < SwiftRValue(5))
        
        XCTAssertFalse(SwiftRValue(false) < SwiftRValue(true))
        XCTAssertFalse(SwiftRValue(5) < SwiftRValue(false))
        XCTAssertFalse(SwiftRValue(10) < SwiftRValue(5))
        XCTAssertFalse(SwiftRValue("a") < SwiftRValue(10))
        XCTAssertFalse(SwiftRValue("b") < SwiftRValue("a"))
        XCTAssertFalse(SwiftRValue("a") < SwiftRValue(false))
        XCTAssertFalse(SwiftRValue(5) < SwiftRValue(true))
        
        XCTAssertFalse(SwiftRValue(true) < SwiftRValue(true))
        XCTAssertFalse(SwiftRValue(5) < SwiftRValue(5))
        XCTAssertFalse(SwiftRValue("a") < SwiftRValue("a"))
        
        XCTAssertFalse(SwiftRValue(true) > SwiftRValue(true))
        XCTAssertFalse(SwiftRValue(5) > SwiftRValue(5))
        XCTAssertFalse(SwiftRValue("a") > SwiftRValue("a"))
    }
    
    func testDescriptions() {
        XCTAssertEqual(stringValue.description, "Testing".description)
        XCTAssertEqual(doubleValue.description, 10.0.description)
        XCTAssertEqual(logicalValue.description, true.description)
    }
    

}
