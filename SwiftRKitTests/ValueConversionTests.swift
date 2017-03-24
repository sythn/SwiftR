//
//  ValueConversionTests.swift
//  SwiftR
//
//  Created by Seyithan Teymur on 24/03/2017.
//  Copyright © 2017 Brokoli. All rights reserved.
//

import XCTest
@testable import SwiftRKit

class ValueConversionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    func testCompareValues() {
        XCTAssertGreaterThan(SwiftRValueType.string, .numeric)
        XCTAssertGreaterThan(SwiftRValueType.numeric, .logical)
    }
    
    func testGreatestTypeInArray() {
        let logicalArray: [SwiftRValue] = [true, false, false]
        XCTAssertEqual(logicalArray.greatestType, .logical)
        
        let numericArray: [SwiftRValue] = [1, 3, 10.5]
        XCTAssertEqual(numericArray.greatestType, .numeric)
        
        let stringArray: [SwiftRValue] = ["testing", "the", "string"]
        XCTAssertEqual(stringArray.greatestType, .string)
        
        let mix1: [SwiftRValue] = [true, false, 10.2]
        XCTAssertEqual(mix1.greatestType, .numeric)
        
        let mix2: [SwiftRValue] = [1, 8, "and a string"]
        XCTAssertEqual(mix2.greatestType, .string)
        
        let mix3: [SwiftRValue] = [1, true, false, "string", 10.5]
        XCTAssertEqual(mix3.greatestType, .string)
    }
    
    func testValueConversions() {
        XCTAssertEqual(SwiftRValue(true).logical, true)
        XCTAssertEqual(SwiftRValue(false).logical, false)
        XCTAssertEqual(SwiftRValue(true).numeric, 1)
        XCTAssertEqual(SwiftRValue(false).numeric, 0)
        XCTAssertEqual(SwiftRValue(true).string, "true")
        XCTAssertEqual(SwiftRValue(false).string, "false")
        
        XCTAssertEqual(SwiftRValue(10.2).logical, true)
        XCTAssertEqual(SwiftRValue(0).logical, false)
        XCTAssertEqual(SwiftRValue(10.2).numeric, 10.2)
        XCTAssertEqual(SwiftRValue(0).numeric, 0)
        XCTAssertEqual(SwiftRValue(10.2).string, "10.2")
        XCTAssertEqual(SwiftRValue(0).string, "0.0")
        
        XCTAssertEqual(SwiftRValue("true").logical, true)
        XCTAssertEqual(SwiftRValue("not true").logical, false)
        XCTAssertEqual(SwiftRValue("10.2").numeric, 10.2)
        XCTAssertEqual(SwiftRValue("0").numeric, 0)
        XCTAssertEqual(SwiftRValue("not even").numeric, .nan)
        XCTAssertEqual(SwiftRValue("10.2").string, "10.2")
        XCTAssertEqual(SwiftRValue("0").string, "0")
    }
    
    func testHomogenousArrayConversion() {
        let logicalArray: [SwiftRValue] = [true, false, false]
        XCTAssertEqual(logicalArray.convertedToGreatestType(), logicalArray)
        
        let numericArray: [SwiftRValue] = [10.2, 2, 8]
        XCTAssertEqual(numericArray.convertedToGreatestType(), numericArray)
        
        let stringArray: [SwiftRValue] = ["testing", "some", "strings"]
        XCTAssertEqual(stringArray.convertedToGreatestType(), stringArray)
    }
    
    func testHeterogenousArrayConversion() {
        let logicalAndNumerical: [SwiftRValue] = [true, false, false, 10.2]
        XCTAssertEqual(logicalAndNumerical.convertedToGreatestType(), [1, 0, 0, 10.2])
        
        let logicalAndString: [SwiftRValue] = [true, false, false, "some string"]
        XCTAssertEqual(logicalAndString.convertedToGreatestType(), ["true", "false", "false", "some string"])
        
        let numericalAndString: [SwiftRValue] = [2, 10.2, "some string", 0]
        XCTAssertEqual(numericalAndString.convertedToGreatestType(), ["2.0", "10.2", "some string", "0.0"])
        
        let mix: [SwiftRValue] = ["some string", true, 3]
        XCTAssertEqual(mix.convertedToGreatestType(), ["some string", "true", "3.0"])
    }

}
