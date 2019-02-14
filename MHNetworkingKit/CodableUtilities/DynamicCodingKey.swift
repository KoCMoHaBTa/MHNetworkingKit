//
//  DynamicCodingKey.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 14.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

///A type that can represent any single coding key dynamically
public struct DynamicCodingKey: CodingKey {
    
    public let stringValue: String
    public let intValue: Int?
    
    public init?(stringValue: String) {
        
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }
    
    public init?(intValue: Int) {
        
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}

extension DynamicCodingKey: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) { self.init(stringValue: value)! }
    public init(unicodeScalarLiteral value: String) { self.init(stringValue: value)! }
    public init(extendedGraphemeClusterLiteral value: String) { self.init(stringValue: value)! }
}

extension DynamicCodingKey: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) { self.init(intValue: value)! }
}
