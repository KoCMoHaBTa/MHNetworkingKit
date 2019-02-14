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
        
        return try self.decode(T.self, forKey: key)
    }
    
    ///Decodes a value for the given key or alternative keys.
    public func decode<T>(forKey key: Key, or additionalKeys: [Key]) throws -> T where T: Decodable {
        
        if let value: T = try? self.decode(forKey: key) {
            
            return value
        }
        
        for key in additionalKeys {
            
            if let value: T = try? self.decode(forKey: key) {
                
                return value
            }
        }
        
        return try self.decode(forKey: key)
    }
    
    ///Decodes a value for the given key, if present.
    public func decodeIfPresent<T>(forKey key: Key) throws -> T? where T: Decodable {
        
        return try self.decodeIfPresent(T.self, forKey: key)
    }
    
    ///Decodes a value for the given key, applying a transformation block from one type to another.
    public func decode<T, U>(forKey key: Key, transform: (U) throws -> T) throws -> T where T: Decodable, U: Decodable {
        
        let original: U = try self.decode(U.self, forKey: key)
        return try transform(original)
    }
    
    ///Decodes a value for the given key, if present, applying a transformation block from one type to another.
    public func decodeIfPresent<T, U>(forKey key: Key, transform: (U?) throws -> T?) throws -> T? where T: Decodable, U: Decodable {
        
        let original = try self.decodeIfPresent(U.self, forKey: key)
        return try transform(original)
    }
    
    ///Decodes an array value for the given key, throwing away elements that cannot be decoded and returning successfully decoded elements.
    public func decodeArray<T>(forKey key: Key) throws -> [T] where T: Decodable {
        
        var result: [T] = []
        
        guard var container = try? self.nestedUnkeyedContainer(forKey: key) else {
            
            return result
        }
        
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
    public func decodeArray<T, U>(forKey key: Key, transform: ([U]) throws -> [T]) throws -> [T] where T: Decodable, U: Decodable {
        
        let original: [U] = try self.decodeArray(forKey: key)
        return try transform(original)
    }
}

///A type used when decoding array to throw away invalid elements
private struct UselessCodable: Codable {}
