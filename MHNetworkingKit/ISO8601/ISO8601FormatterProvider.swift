//
//  ISO8601FormatterProvider.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 28.04.21.
//  Copyright © 2021 Milen Halachev. All rights reserved.
//

import Foundation

/**
 A type that statically provides formatter for a `ISO8601Formattable` value.
 In order to use custom formatter with `ISO8601Formatted` property wrapper:
    1. Subsclass `ISO8601FormatterProvider` and specify your value type
    2. Override the `formatter` class var and return instnace of your custom formatter
    3. Provide you custom formatter, eg `@ISO8601Formatted(formatterProvider: MyCustomFormatterProvider.self) var myValue: Date`
 */
@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
open class ISO8601FormatterProvider<Value: ISO8601Formattable> {
    
    open class var formatter: Value.Formatter { Value.defaultFormatter }
}
