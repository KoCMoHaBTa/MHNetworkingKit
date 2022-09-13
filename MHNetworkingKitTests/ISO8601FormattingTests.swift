//
//  ISO8601FormattingTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 18.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHNetworkingKit

@available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *)
class ISO8601FormattingTests: XCTestCase {
    
    let jsonPresent =
    """
    { "date": "2020-02-19T19:30:00Z" }
    """
    
    let jsonNotPresent =
    """
    {}
    """
    
    let jsonNull =
    """
    { "date": null }
    """
    
    let jsonWrongValue =
    """
    { "date": "pasta" }
    """
    
    let jsonWrongType =
    """
    { "date": 5 }
    """

    let jsonArrayAllCorrect =
    """
    { "date": ["2020-02-19T19:30:00Z", "2021-02-19T19:30:00Z", "2022-02-19T19:30:00Z", "2023-02-19T19:30:00Z"] }
    """

    let jsonArraySomeWrong =
    """
    { "date": [true, "2020-02-19T19:30:00Z", "a", 5, "2023-02-19T19:30:00Z", null] }
    """

    let jsonArrayAllWrong =
    """
    { "date": [true, "a", 5, null] }
    """
    
    struct RequiredMock: Codable {
        
        @ISO8601Formatted var date: Date
    }
    
    struct OptionalMock: Codable {
        
        @ISO8601Formatted var date: Date?
    }

    struct ArrayMock: Codable {

        @ISO8601Formatted var date: [Date]
    }
    
    func testRequiredCodable() {
        
        XCTAssertEqual(RequiredMock(json: jsonPresent)?.$date, "2020-02-19T19:30:00Z")
        XCTAssertNil(RequiredMock(json: jsonNotPresent))
        XCTAssertNil(RequiredMock(json: jsonNull))
        XCTAssertNil(RequiredMock(json: jsonWrongValue))
        XCTAssertNil(RequiredMock(json: jsonWrongType))
    }
    
    func testOptionalCodable() {
     
        XCTAssertEqual(OptionalMock(json: jsonPresent)?.$date, "2020-02-19T19:30:00Z")
        XCTAssertNotNil(OptionalMock(json: jsonNotPresent))
        XCTAssertNotNil(OptionalMock(json: jsonNull))
        XCTAssertNotNil(OptionalMock(json: jsonWrongValue))
        XCTAssertNotNil(OptionalMock(json: jsonWrongType))
    }

    func testArrayDecodable() {
      XCTAssertEqual(ArrayMock(json: jsonArrayAllCorrect)?.$date, ["2020-02-19T19:30:00Z", "2021-02-19T19:30:00Z", "2022-02-19T19:30:00Z", "2023-02-19T19:30:00Z"])
      XCTAssertEqual(ArrayMock(json: jsonArraySomeWrong)?.$date, ["2020-02-19T19:30:00Z", "2023-02-19T19:30:00Z"])
      XCTAssertEqual(ArrayMock(json: jsonArrayAllWrong)?.$date, [])
    }
    
    func testDecodingUsingCustomFormatter() {
        
        let json =
        """
        { "date": "2020-02-19", "nilDate": null, "invalidDateString": "5asd123", "invalidDateInt": 5 }
        """
    
        class FormatterProvider: ISO8601FormatterProvider<Date?> {
            
            override class var formatter: ISO8601DateFormatter { .init(formatOptions: [.withFullDate, .withDashSeparatorInDate], timeZone: .current) }
        }
        
        struct Mock: Codable {
            
            @ISO8601Formatted(formatterProvider: FormatterProvider.self) var date: Date? = nil
            @ISO8601Formatted(formatterProvider: FormatterProvider.self) var nilDate: Date? = nil
            @ISO8601Formatted(formatterProvider: FormatterProvider.self) var missingDate: Date? = nil
            @ISO8601Formatted(formatterProvider: FormatterProvider.self) var invalidDateString: Date? = nil
            @ISO8601Formatted(formatterProvider: FormatterProvider.self) var invalidDateInt: Date? = nil
        }
        
        let mock = Mock(json: json)
        XCTAssertEqual(mock?.$date, "2020-02-19")
        XCTAssertNil(mock?.nilDate)
        XCTAssertNil(mock?.missingDate)
        XCTAssertNil(mock?.invalidDateString)
        XCTAssertNil(mock?.invalidDateInt)
    }
}
