//
//  LossyDecodable.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 25.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

/**
 A type that supports lossy decoding.
 Currently supports types are:
 - Array - discards any elements that cannot be decoded
 - Set - discards any elements that cannot be decoded
 - Dictionary - discards any values that cannot be decoded
 - Optional - defaults to `nil` if cannot be decoded
 */

public protocol LossyDecodable {
    
    init()
    init(lossyDecodedFrom decoder: Decoder) throws
    init(lossyDecodedFrom decoder: Decoder, logger: Logger) throws
}

extension LossyDecodable {
    
    public init(lossyDecodedFrom decoder: Decoder) throws {
        
        try self.init(lossyDecodedFrom: decoder, logger: .default)
    }
}

///A type used when decoding array to throw away invalid elements
private struct UselessCodable: Codable {}

extension Array: LossyDecodable where Element: Decodable {
    
    public init(lossyDecodedFrom decoder: Decoder, logger: Logger) throws {
        
        var result: [Element] = []
        var container = try decoder.unkeyedContainer()
        
        for _ in 0..<(container.count ?? 0) {
            
            do {
                
                let element: Element = try container.decode()
                result.append(element)
            }
            catch {
                
                logger.log(error)
                
                //https://bugs.swift.org/browse/SR-5953
                //throw the data away
                _ = try? container.decode(UselessCodable.self)
            }
        }

        self = result
    }
}

extension Set: LossyDecodable where Element: Decodable {
    
    public init(lossyDecodedFrom decoder: Decoder, logger: Logger) throws {
        
        var result: Set<Element> = Set()
        var container = try decoder.unkeyedContainer()

        for _ in 0..<(container.count ?? 0) {
            
            do {
                
                let element: Element = try container.decode()
                result.insert(element)
            }
            catch {
                
                logger.log(error)
                
                //https://bugs.swift.org/browse/SR-5953
                //throw the data away
                _ = try? container.decode(UselessCodable.self)
            }
        }

        self = result
    }
}

extension Dictionary: LossyDecodable where Key == String, Value: Decodable {
    
    public init(lossyDecodedFrom decoder: Decoder, logger: Logger) throws {
        
        var result: Dictionary<Key, Value> = [:]
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        
        container.allKeys.forEach { (codingKey) in
            
            let key: Key = codingKey.stringValue
            let value: Value? = try? container.decode(forKey: codingKey)
            result[key] = value
        }

        self = result
    }
}

extension Optional: LossyDecodable where Wrapped: Decodable {
    
    public init() {
        
        self = .none
    }
    
    public init(lossyDecodedFrom decoder: Decoder, logger: Logger) throws {
        
        self = try? Self.init(from: decoder)
    }
}
