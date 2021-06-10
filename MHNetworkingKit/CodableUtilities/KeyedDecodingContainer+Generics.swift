//
//  KeyedDecodingContainer+Generics.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 14.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
    ///Decodes a value for the given key.
    public func decode<T>(forKey key: Key) throws -> T where T: Decodable {
        
        try decode(T.self, forKey: key)
    }
    
    ///Decodes a value for the given key or alternative keys.
    public func decode<T>(forKey key: Key, or additionalKeys: [Key]) throws -> T where T: Decodable {
        
        if let value: T = try? decode(forKey: key) {
            
            return value
        }
        
        for key in additionalKeys {
            
            if let value: T = try? decode(forKey: key) {
                
                return value
            }
        }
        
        return try decode(forKey: key)
    }
    
    ///Decodes a value for the given key, if present.
    public func decodeIfPresent<T>(forKey key: Key) throws -> T? where T: Decodable {
        
        try decodeIfPresent(T.self, forKey: key)
    }
    
    ///Decodes a value for the given key, applying a transformation block from one type to another.
    public func decode<T, U>(forKey key: Key, transform: (U) throws -> T) throws -> T where T: Decodable, U: Decodable {
        
        try transform(decode(U.self, forKey: key))
    }
    
    ///Decodes a value for the given key, if present, applying a transformation block from one type to another.
    public func decodeIfPresent<T, U>(forKey key: Key, transform: (U?) throws -> T?) throws -> T? where T: Decodable, U: Decodable {
        
        try transform(decodeIfPresent(U.self, forKey: key))
    }
    
    ///Decodes an array value for the given key, throwing away elements that cannot be decoded and returning successfully decoded elements.
    @available(*, deprecated, message: "Use @LossyDecoded or decodeLossyArray(forKey:) instead")
    public func decodeArray<T>(forKey key: Key) throws -> [T] where T: Decodable {
        
        try decodeLossyArray(forKey: key)
    }
    
    public func decodeLossyArray<T>(forKey key: Key) throws -> [T] where T: Decodable {
        
        var result: [T] = []
        var container = try nestedUnkeyedContainer(forKey: key)
        
        for _ in 0..<(container.count ?? 0) {
            
            do {
                
                let element: T = try container.decode()
                result.append(element)
            }
            catch {
                
                print(error)
                
                //https://bugs.swift.org/browse/SR-5953
                //throw the data away
                _ = try? container.decode(UselessCodable.self)
            }
        }
        
        return result
    }
    
    ///Decodes an array value for the given key, throwing away elements that cannot be decoded and returning successfully decoded elements, applying a transformation block from one type to another.
    
    @available(*, deprecated, message: "Use decodeLossyArray(forKey:transform:) instead")
    public func decodeArray<T, U>(forKey key: Key, transform: ([U]) throws -> [T]) throws -> [T] where T: Decodable, U: Decodable {
        
        try decodeLossyArray(forKey: key, transform: transform)
    }
    
    public func decodeLossyArray<T, U>(forKey key: Key, transform: ([U]) throws -> [T]) throws -> [T] where T: Decodable, U: Decodable {
        
        try transform(decodeLossyArray(forKey: key))
    }
}

///A type used when decoding array to throw away invalid elements
private struct UselessCodable: Codable {}
