//
//  Quantum.swift
//  CoreDataSample
//
//  Created by Deepak Saxena on 09/08/19.
//  Copyright © 2019 Deepak Saxena. All rights reserved.
//

import Foundation

public struct Quantum {
    
    public init?(_ magnitude: Any) {
        if let v = magnitude as? Double {
            self = Quantum(doubleValue: v)
        } else if let v = magnitude as? Float {
            self = Quantum(floatValue: v)
        } else if let v = magnitude as? Int {
            self = Quantum(intValue: v)
        } else if let v = magnitude as? Bool {
            self = Quantum(boolValue: v)
        } else if let v = magnitude as? String {
            self = Quantum(stringValue: v)
        } else if let v = magnitude as? Quantum {
            self = Quantum(stringValue: v.stringValue)
        } else {
            return nil
        }
    }
    
    public var intValue: Int {
        let m = value ?? "0"
        return Int(m) ?? 0
    }
    
    public var doubleValue: Double {
        let m = value ?? "0.0"
        return Double(m) ?? 0.0
    }
    
    public var floatValue: Float {
        let m = value ?? "0.0"
        return Float(m) ?? 0.0
    }
    
    public var stringValue: String {
        return value ?? ""
    }
    
    public var boolValue: Bool {
        return (self.value?.lowercased() == "true" || self.intValue == 1)
    }
    
    private var value: String?
    
    private init(intValue: Int) {
        self.value = "\(intValue)"
    }
    
    private init(stringValue: String) {
        self.value = "\(stringValue)"
    }
    
    private init(floatValue: Float) {
        self.value = "\(floatValue)"
    }
    
    private init(doubleValue: Double) {
        self.value = "\(doubleValue)"
    }
    
    private init(boolValue: Bool) {
        self.value = "\(boolValue)"
    }
    
}

extension Quantum: Comparable {
    
    public static func < (lhs: Quantum, rhs: Quantum) -> Bool {
        return lhs.stringValue < rhs.stringValue
    }
    
    public static func == (lhs: Quantum, rhs: Quantum) -> Bool {
        return lhs.stringValue == rhs.stringValue
    }
    
    public static func >= (lhs: Quantum, rhs: Quantum) -> Bool {
        return lhs.stringValue >= rhs.stringValue
    }
}

extension Quantum {
    
    public static func * (lhs: Quantum, rhs: Quantum) -> Quantum {
        return Quantum(lhs.doubleValue * rhs.doubleValue)!
    }
    
    public static func *= (lhs: inout Quantum, rhs: Quantum) {
        lhs = Quantum(lhs.doubleValue * rhs.doubleValue)!
    }
    
    public static func - (lhs: Quantum, rhs: Quantum) -> Quantum {
        return Quantum(lhs.doubleValue - rhs.doubleValue)!
    }
    
    public static func -= (lhs: inout Quantum, rhs: Quantum) {
        lhs = Quantum(lhs.doubleValue + rhs.doubleValue)!
    }
    
    public static func + (lhs: Quantum, rhs: Quantum) -> Quantum {
        return Quantum(lhs.doubleValue + rhs.doubleValue)!
    }
    
    public static func += (lhs: inout Quantum, rhs: Quantum) {
        lhs = Quantum(lhs.doubleValue + rhs.doubleValue)!
    }
}

extension Quantum: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return self.stringValue
    }
    
    public var debugDescription: String {
        return self.stringValue
    }
}


extension Quantum: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByStringLiteral, ExpressibleByNilLiteral, ExpressibleByBooleanLiteral {
    
    public typealias IntegerLiteralType = Int
    public typealias StringLiteralType = String
    public typealias FloatLiteralType = Float
    public typealias BooleanLiteralType = Bool
    
    public init(integerLiteral value: Int) {
        self.value = "\(value)"
    }
    
    public init(nilLiteral: ()) {
        self.value = nil
    }
    
    public init(floatLiteral value: Float) {
        self.value = "\(value)"
    }
    
    public init(stringLiteral value: String) {
        self.value = "\(value)"
    }
    
    public init(booleanLiteral value: Bool) {
        self.value = "\(value)"
    }
}


extension Quantum: Codable {

    public init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()
        
        if let dbl = try? values.decode(Double.self), dbl.truncatingRemainder(dividingBy: 1) != 0  { // It is double not a int value
            self =  Quantum(doubleValue: dbl)
        } else if let int = try? values.decode(Int.self) {
            self = Quantum(intValue: int)
        } else if let float = try? values.decode(Float.self) {
            self = Quantum(floatValue: float)
        } else if let bool = try? values.decode(Bool.self) {
            self = Quantum(boolValue: bool)
        } else if let string = try? values.decode(String.self) {
            self = Quantum(stringValue: string)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.value ?? "")
    }
}

