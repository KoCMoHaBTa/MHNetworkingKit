//
//  AnyCodingKey.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 25.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

public struct AnyCodingKey: CodingKey {
    
    public var stringValue: String
    public var intValue: Int?

    public init?(stringValue: String) {
        
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }
    
    public init?(intValue: Int) {
        
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}

extension AnyCodingKey: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) { self.init(stringValue: value)! }
}

extension AnyCodingKey: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) { self.init(intValue: value)! }
}
