//
//  LossyDecoded.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 25.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

/**
 A property wrapped that performs lossy decoding on the wrapped value.
 For more information on supported types - see `LossyDecodable`.
 */
@propertyWrapper
public struct LossyDecoded<T: LossyDecodable> {

    public var wrappedValue: T

    public init(wrappedValue: T) {

        self.wrappedValue = wrappedValue
    }
}

extension LossyDecoded: Encodable where T: Encodable {

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension LossyDecoded: Decodable where T: Decodable {
    
    public init(from decoder: Decoder) throws {
        
        wrappedValue = try .init(lossyDecodedFrom: decoder)
    }
}

extension LossyDecoded: Hashable where T: Hashable {}
extension LossyDecoded: Equatable where T: Equatable {}

//A hack to make optional decoding of property wrappers to work when key is missing
//https://stackoverflow.com/a/60108000/1608577
//https://forums.swift.org/t/using-property-wrappers-with-codable/29804/12
extension KeyedDecodingContainer {

    //support for any decodable optional
    public func decode<T>(_ type: LossyDecoded<T?>.Type, forKey key: Self.Key) throws -> LossyDecoded<T?> where T : Decodable {
        
        (try? self.decodeIfPresent(type, forKey: key)) ?? LossyDecoded<T?>(wrappedValue: nil)
    }
    
    //support for lossy decodable optional
    public func decode<T>(_ type: LossyDecoded<T?>.Type, forKey key: Self.Key) throws -> LossyDecoded<T?> where T : LossyDecodable {
        
        LossyDecoded<T?>(wrappedValue: try? T(lossyDecodedFrom: superDecoder(forKey: key)))
    }
    
    //support for lossy decodable non-optional 
    public func decode<T>(_ type: LossyDecoded<T>.Type, forKey key: Self.Key) throws -> LossyDecoded<T> where T : Decodable {
        
        (try? self.decodeIfPresent(type, forKey: key)) ?? LossyDecoded<T>(wrappedValue: T.init())
    }
}

