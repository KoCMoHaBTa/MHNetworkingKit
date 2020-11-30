//
//  ISO8601Formatted.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 18.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

///A property wrapper of Date/Date? that represents it from/to ISO8601 formatted String. Used for convenience Encoding/Decoding of Date properties from/to ISO8601 formatted String, without the need to specify dateDecodingStrategy/dateEncodingStrategy of JSONDecoder/JSONEncoder.
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
@propertyWrapper
public struct ISO8601Formatted<T: ISO8601Formattable> {
    
    public var wrappedValue: T
    public var formatter: T.Formatter
    
    public var projectedValue: T.FormattedValue {
        
        return self.wrappedValue.iso8601FormattedValue(using: self.formatter)
    }

    public init(wrappedValue: T, formatter: T.Formatter = T.defaultFormatter) {
        
        self.wrappedValue = wrappedValue
        self.formatter = formatter
    }
    
    public init(_ value: T, formatter: T.Formatter = T.defaultFormatter) {
        
        self.init(wrappedValue: value, formatter: formatter)
    }
}

///Conforms to Codable
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension ISO8601Formatted: Codable where T.FormattedValue: Codable {

    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()
        let formattedValue = try container.decode(T.FormattedValue.self)
        
        guard let value = T(fromISO8601FormattedValue: formattedValue) else {

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "The supplied value does conform to ISO8601 date standard.")
        }

        self.init(value)
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()
        try container.encode(self.projectedValue)
    }
}

///Conforms to RawRepresentable
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension ISO8601Formatted: RawRepresentable {

    public var rawValue: T.FormattedValue {

        return self.projectedValue
    }

    public init?(rawValue: T.FormattedValue) {

        guard let value = T(fromISO8601FormattedValue: rawValue) else {
            
            return nil
        }
        
        self.init(value)
    }
}

///Conforms to ExpressibleByStringLiteral
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension ISO8601Formatted: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where T.FormattedValue == String {

    public init(stringLiteral value: T.FormattedValue) {

        let value = T(fromISO8601FormattedValue: value)!
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: T.FormattedValue) {

        self.init(stringLiteral: value)
    }

    public init(extendedGraphemeClusterLiteral value: T.FormattedValue) {

        self.init(stringLiteral: value)
    }
}

///Conforms to CustomStringConvertible
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension ISO8601Formatted: CustomStringConvertible {

    public var description: String {

        return String(describing: self.projectedValue)
    }
}

///Conforms to Equatable
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension ISO8601Formatted: Equatable where T: Equatable {
    
    public static func == (lhs: ISO8601Formatted<T>, rhs: ISO8601Formatted<T>) -> Bool {
        
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

///Conforms to Equatable
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension ISO8601Formatted: Hashable where T: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        
        self.wrappedValue.hash(into: &hasher)
    }
}

//A hack to make optional decoding of property wrappers to work when key is missing
//https://stackoverflow.com/a/60108000/1608577
//https://forums.swift.org/t/using-property-wrappers-with-codable/29804/12
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension KeyedDecodingContainer {

    public func decode<T>(_ type: ISO8601Formatted<T?>.Type, forKey key: Self.Key) throws -> ISO8601Formatted<T?> where T : Decodable {
        
        return (try? decodeIfPresent(type, forKey: key)) ?? ISO8601Formatted<T?>(wrappedValue: nil)
    }
}

