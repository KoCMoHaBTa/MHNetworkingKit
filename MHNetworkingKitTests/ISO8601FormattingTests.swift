//
//  ISO8601FormattingTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 18.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
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
    
    struct RequiredMock: Codable {
        
        @ISO8601Formatted var date: Date
    }
    
    struct OptionalMock: Codable {
        
        @ISO8601Formatted var date: Date?
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
}
#endif
