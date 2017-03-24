//
//  ValueConversion.swift
//  SwiftR
//
//  Created by Seyithan Teymur on 24/03/2017.
//  Copyright © 2017 Brokoli. All rights reserved.
//

import Foundation

extension SwiftRValueType: Comparable {
    static func <(left: SwiftRValueType, right: SwiftRValueType) -> Bool {
        return left.rawValue < right.rawValue
    }
}

extension Array where Element: _SwiftRValue {
    var greatestType: SwiftRValueType {
        var greatest = SwiftRValueType.logical
        
        for element in self {
            if element.type > greatest {
                greatest = element.type
            }
            
            if greatest == .string {
                break
            }
        }
        
        return greatest
    }
}

protocol SwiftRValueInterchangable: _SwiftRValue {
    var logical: Self { get }
    var numeric: Self { get }
    var string: Self { get }
    
    func convertTo(type: SwiftRValueType) -> Self
}

extension SwiftRValueInterchangable {
    func convertTo(type: SwiftRValueType) -> Self {
        switch type {
        case .logical:
            return self.logical
            
        case .numeric:
            return self.numeric
            
        case .string:
            return self.string
        }
    }
}

extension Array where Element: SwiftRValueInterchangable {
    
    func convertedToGreatestType() -> [Element] {
        let greatestType = self.greatestType
        
        let converted = self.map { (value) -> Element in
            return value.convertTo(type: greatestType)
        }
        
        return converted
    }
    
    mutating func convertToGreatestType() {
        self = self.convertedToGreatestType()
    }
}

extension SwiftRValue: SwiftRValueInterchangable {
    
    var logical: SwiftRValue {
        switch self {
        case .numeric(let value):
            return SwiftRValue(value != 0)
            
        case .string(let value):
            if value.lowercased() == "true" {
                return true
            } else {
                return false
            }
            
        default:
            return self
        }
    }
    
    var numeric: SwiftRValue {
        switch self {
        case .logical(let value):
            return value == true ? 1 : 0
            
        case .string(let value):
            if let number = Double(value) {
                return SwiftRValue(number)
            } else {
                return .nan
            }
        
        default:
            return self
        }
    }
    
    var string: SwiftRValue {
        switch self {
        case .logical(let value):
            return value ? "true" : "false"
            
        case .numeric(let value):
            return SwiftRValue(String(value))
            
        default:
            return self
        }
    }
}
