//
//  AnyEncodableValue.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 14.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

//A type eraser that can represents any encodable primitive value
public struct AnyEncodableValue: Encodable {
    
    public var value: Any?
    
    public init(value: Any?) {
        
        self.value = value
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        guard let value = value else {
            
            try container.encodeNil()
            return
        }
        
        switch type(of: value) {
            
            case is Date.Type:
                try container.encode(value as! Date)
            
            case is URL.Type:
                try container.encode(value as! URL)
            
            case is String.Type:
                try container.encode(value as! String)
            
            case is Bool.Type:
                try container.encode(value as! Bool)
            
            case is Int.Type:
                try container.encode(value as! Int)
            
            case is Float.Type:
                try container.encode(value as! Float)
            
            case is Double.Type:
                try container.encode(value as! Double)
            
            default:
                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unsupported JSON type"))
        }
    }
}

extension AnyEncodableValue: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) { self.value = value }
}

extension AnyEncodableValue: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) { self.value = value }
}

extension AnyEncodableValue: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) { self.value = value }
}

extension AnyEncodableValue: ExpressibleByBooleanLiteral {
 
    public init(booleanLiteral value: Bool) { self.value = value }
}
