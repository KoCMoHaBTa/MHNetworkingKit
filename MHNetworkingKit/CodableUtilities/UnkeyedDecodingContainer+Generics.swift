//
//  UnkeyedDecodingContainer+Generics.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 14.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension UnkeyedDecodingContainer {
    
    ///Decodes a value.
    public mutating func decode<T>() throws -> T where T: Decodable {
        
        try decode(T.self)
    }
    
    ///Decodes a value, if prsent.
    public mutating func decodeIfPresent<T>() throws -> T? where T: Decodable {
        
        try decodeIfPresent(T.self)
    }
    
    ///Decodes a value, applying a transformation block from one type to another.
    public mutating func decode<T, U>(transform: (U) throws -> T) throws -> T where T: Decodable, U: Decodable {
        
        try transform(decode(U.self))
    }
    
    ///Decodes a value, if present, applying a transformation block from one type to another.
    public mutating func decodeIfPresent<T, U>(transform: (U?) throws -> T?) throws -> T? where T: Decodable, U: Decodable {
        
        try transform(decodeIfPresent(U.self))
    }
    
    ///Decodes an array value, throwing away elements that cannot be decoded and returning successfully decoded elements.
    @available(*, deprecated, message: "Use @LossyDecoded or decodeLossyArray() instead")
    public mutating func decodeArray<T>() throws -> [T] where T: Decodable {
        
        try decodeLossyArray()
    }
    
    public mutating func decodeLossyArray<T>() throws -> [T] where T: Decodable {
        
        var result: [T] = []
        var container = try nestedUnkeyedContainer()
        
        for _ in 0..<(container.count ?? 0) {
            
            if let element: T = try? container.decode() {
                
                result.append(element)
            }
        }
        
        return result
    }
    
    ///Decodes an array value, throwing away elements that cannot be decoded and returning successfully decoded elements, applying a transformation block from one type to another.
    @available(*, deprecated, message: "Use decodeLossyArray(transform:) instead")
    public mutating func decodeArray<T, U>(transform: ([U]) throws -> [T]) throws -> [T] where T: Decodable, U: Decodable {
        
        try decodeLossyArray(transform: transform)
    }
    
    public mutating func decodeLossyArray<T, U>(transform: ([U]) throws -> [T]) throws -> [T] where T: Decodable, U: Decodable {
        
        try transform(decodeLossyArray())
    }
}
