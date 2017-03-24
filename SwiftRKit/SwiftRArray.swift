//
//  SwiftRArray.swift
//  SwiftR
//
//  Created by Seyithan Teymur on 24/03/2017.
//  Copyright © 2017 Brokoli. All rights reserved.
//

import Foundation

protocol SwiftRContainer {
    var valueType: SwiftRValueType { get }
    var array: Array<SwiftRValue> { get }
    
    init(_: [SwiftRValue])
}

struct SwiftRArray: SwiftRContainer {
    var valueType: SwiftRValueType
    var array: [SwiftRValue]
    
    init(_ array: [SwiftRValue]) {
        self.valueType = array.greatestType
        self.array = array.convertedToGreatestType()
    }
}

extension SwiftRArray: Equatable {
    static func ==(left: SwiftRArray, right: SwiftRArray) -> Bool {
        return left.array == right.array
    }
}

extension SwiftRArray: ExpressibleByArrayLiteral {
    typealias Element = SwiftRValue
    
    init(arrayLiteral elements: SwiftRValue...) {
        self.init(elements)
    }
}

extension SwiftRArray {
    subscript(index: Int) -> SwiftRValue {
        return self.array[index]
    }
}
