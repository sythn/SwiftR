//
//  ArrayTests.swift
//  SwiftR
//
//  Created by Seyithan Teymur on 25/03/2017.
//  Copyright © 2017 Brokoli. All rights reserved.
//

import XCTest
@testable import SwiftRKit

class ArrayTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    func testArrayWithLiterals() {
        let array1: SwiftRArray = [true, 10.2]
        XCTAssertEqual(array1.valueType, .numeric)
        XCTAssertEqual(array1[1], 10.2)
        XCTAssertEqual(array1[1].type, .numeric)
    }

}
