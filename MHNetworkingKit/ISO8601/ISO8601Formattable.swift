//
//  ISO8601Formattable.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 18.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

///A type that can be formatted from/to ISO8601 format. Used for conditional implementation of ISO8601Formatted property wrapper in order to support both Date and Date?
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
public protocol ISO8601Formattable {
    
    associatedtype Formatter
    associatedtype FormattedValue
    
    static var defaultFormatter: Formatter { get set }
    
    init?(fromISO8601FormattedValue value: FormattedValue, using formatter: Formatter)
    init?(fromISO8601FormattedValue value: FormattedValue)
    
    func iso8601FormattedValue(using formatter: Formatter) -> FormattedValue
    func iso8601FormattedValue() -> FormattedValue
}

///Default convenience implementation
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension ISO8601Formattable {
    
    public init?(fromISO8601FormattedValue value: FormattedValue) {
        
        self.init(fromISO8601FormattedValue: value, using: Self.defaultFormatter)
    }
    
    public func iso8601FormattedValue() -> FormattedValue {
        
        return self.iso8601FormattedValue(using: Self.defaultFormatter)
    }
}

///Makes Date conforming to ISO8601Formattable
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Date: ISO8601Formattable {
    
    public static var defaultFormatter: ISO8601DateFormatter = .init()
    
    public init?(fromISO8601FormattedValue value: String, using formatter: ISO8601DateFormatter) {
        
        guard let date = formatter.date(from: value) else {
            
            return nil
        }
        
        self = date
    }
    
    public func iso8601FormattedValue(using formatter: ISO8601DateFormatter) -> String {
        
        return formatter.string(from: self)
    }
}

///Makes Date? conforming to ISO8601Formattable
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Optional: ISO8601Formattable where Wrapped == Date {
    
    public static var defaultFormatter: ISO8601DateFormatter {
        
        get { return Wrapped.defaultFormatter }
        set { Wrapped.defaultFormatter = newValue }
    }
    
    public init?(fromISO8601FormattedValue value: String?, using formatter: ISO8601DateFormatter) {
        
        guard let value = value else {
            
            return nil
        }
        
        self = formatter.date(from: value)
    }
    
    public func iso8601FormattedValue(using formatter: ISO8601DateFormatter) -> String? {
        
        guard let self = self else {
            
            return nil
        }
        
        return formatter.string(from: self)
    }
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
extension Array: ISO8601Formattable where Element == Date {
    
    public static var defaultFormatter: ISO8601DateFormatter {
        
        get { return Element.defaultFormatter }
        set { Element.defaultFormatter = newValue }
    }
    
    public init?(fromISO8601FormattedValue value: [String], using formatter: ISO8601DateFormatter) {
        
        let dates = value.compactMap { (value) -> Date? in
            
            return formatter.date(from: value)
        }
        
        self = dates
    }
    
    public func iso8601FormattedValue(using formatter: ISO8601DateFormatter) -> [String] {
        
        return self.compactMap { (date) -> String? in
            
            formatter.string(from: date)
        }
    }
}
