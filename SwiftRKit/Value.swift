//
//  Value.swift
//  SwiftR
//
//  Created by Seyithan Teymur on 24/03/2017.
//  Copyright © 2017 Brokoli. All rights reserved.
//

import Foundation

enum SwiftRValueType: Int {
    case logical = 0
    case numeric
    case string
}

protocol _SwiftRValue {
    var type: SwiftRValueType { get }
}

enum SwiftRValue: _SwiftRValue {
    case string(_: String)
    case numeric(_: Double)
    case logical(_: Bool)
    
    var type: SwiftRValueType {
        switch self {
        case .string(_):
            return .string
            
        case .numeric(_):
            return .numeric
            
        case .logical(_):
            return .logical
        }
    }
}

extension SwiftRValue {
    static let nan = SwiftRValue.numeric(Double.nan)
}

extension SwiftRValue: RawRepresentable {
    typealias RawValue = Any & CustomStringConvertible
    
    init(rawValue: SwiftRValue.RawValue) {
        if let value = rawValue as? Bool {
            self = .logical(value)
        } else if let value = rawValue as? FloatLiteralType {
            self = .numeric(Double(value))
        } else if let value = rawValue as? IntegerLiteralType {
            self = .numeric(Double(value))
        } else if let value = rawValue as? String {
            self = .string(value)
        } else {
            self = .string(rawValue.description)
        }
    }
    
    init(_ rawValue: SwiftRValue.RawValue) {
        self.init(rawValue: rawValue)
    }
    
    var rawValue: SwiftRValue.RawValue {
        switch self {
        case .string(let value):
            return value
            
        case .numeric(let value):
            return value
            
        case .logical(let value):
            return value
        }
    }
}

extension SwiftRValue: Equatable {
    static func ==(left: SwiftRValue, right: SwiftRValue) -> Bool {
        switch (left, right) {
        case (.string(let leftValue), .string(let rightValue)):
            return leftValue == rightValue
            
        case (.numeric(let leftValue), .numeric(let rightValue)):
            if leftValue.isNaN && rightValue.isNaN {
                return true
            }
            return leftValue == rightValue
            
        case (.logical(let leftValue), .logical(let rightValue)):
            return leftValue == rightValue
            
        default:
            return false
        }
    }
}

extension SwiftRValue: Comparable {
    static func <(left: SwiftRValue, right: SwiftRValue) -> Bool {
        switch (left, right) {
        case (.logical(let leftValue), .logical(let rightValue)):
            if leftValue == rightValue {
                return false
            }
            return leftValue == true
            
        case (.logical(_), _):
            return true
            
        case (.numeric(let leftValue), .numeric(let rightValue)):
            return leftValue < rightValue
            
        case (.numeric(_), .logical(_)):
            return false
            
        case (.numeric(_), _):
            return true
            
        case (.string(let leftValue), .string(let rightValue)):
            return leftValue < rightValue
            
        case (.string(_), _):
            return false
            
        }
    }
}

extension SwiftRValue: CustomStringConvertible, CustomPlaygroundQuickLookable {
    var description: String {
        return self.rawValue.description
    }
    
    var customPlaygroundQuickLook: PlaygroundQuickLook {
        if let value = rawValue as? CustomPlaygroundQuickLookable {
            return value.customPlaygroundQuickLook
        }
        return PlaygroundQuickLook.init(reflecting: self)
    }
}

extension SwiftRValue: ExpressibleByFloatLiteral {
    typealias FloatLiteralType = Double
    
    init(floatLiteral value: Double) {
        self = .numeric(value)
    }
}

extension SwiftRValue: ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int
    
    init(integerLiteral value: Int) {
        self = .numeric(Double(value))
    }
}

extension SwiftRValue: ExpressibleByBooleanLiteral {
    typealias BooleanLiteralType = Bool
    
    init(booleanLiteral value: Bool) {
        self = .logical(value)
    }
}

extension SwiftRValue: ExpressibleByUnicodeScalarLiteral {
    typealias UnicodeScalarLiteralType = String
    
    init(unicodeScalarLiteral value: String) {
        self = .string(value)
    }
}

extension SwiftRValue: ExpressibleByExtendedGraphemeClusterLiteral {
    typealias ExtendedGraphemeClusterLiteralType = String
    
    init(extendedGraphemeClusterLiteral value: String) {
        self = .string(value)
    }
}

extension SwiftRValue: ExpressibleByStringLiteral {
    typealias StringLiteralType = String
    
    init(stringLiteral value: String) {
        self = .string(value)
    }
}

