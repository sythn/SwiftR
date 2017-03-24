//
//  SwiftRArrayTests.swift
//  SwiftR
//
//  Created by Seyithan Teymur on 25/03/2017.
//  Copyright © 2017 Brokoli. All rights reserved.
//

import XCTest
@testable import SwiftRKit

class SwiftRArrayTests: XCTestCase {
    
    let logical = SwiftRArray([true, false, false])
    let numeric = SwiftRArray([10.2, 2])
    let string = SwiftRArray(["some", "string"])
    
    let logicalAndNumeric = SwiftRArray([true, false, false, 10.2, 2])
    let logicalAndString = SwiftRArray([true, false, false, "some", "string"])
    let numericAndString = SwiftRArray([10.2, 2, "some", "string"])
    let altogether = SwiftRArray([true, 10.2, "string"])
    
    override func setUp() {
        super.setUp()
    }
    
    func testArrayValueType() {
        XCTAssertEqual(logical.valueType, .logical)
        XCTAssertEqual(numeric.valueType, .numeric)
        XCTAssertEqual(string.valueType, .string)
        
        XCTAssertEqual(logicalAndNumeric.valueType, .numeric)
        XCTAssertEqual(logicalAndString.valueType, .string)
        XCTAssertEqual(numericAndString.valueType, .string)
        XCTAssertEqual(altogether.valueType, .string)
    }
    
    func testGreatestTypeConversion() {
        XCTAssertEqual(logical.array, [true, false, false])
        XCTAssertEqual(numeric.array, [10.2, 2])
        XCTAssertEqual(string.array, ["some", "string"])
        
        XCTAssertEqual(logicalAndNumeric.array, [1, 0, 0, 10.2, 2])
        XCTAssertEqual(logicalAndString.array, ["true", "false", "false", "some", "string"])
        XCTAssertEqual(numericAndString.array, ["10.2", "2.0", "some", "string"])
        XCTAssertEqual(altogether.array, ["true", "10.2", "string"])
    }
    
}
