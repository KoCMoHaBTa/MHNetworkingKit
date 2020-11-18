//
//  MHNetworkingKitTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import XCTest
@testable import MHNetworkingKit

class MHNetworkingKitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testURLComponentsPathCompoenents() {
        
        XCTAssertEqual(URLComponents(url: URL(string: "https://foo.bar/a/b/c?o=1&t=2")!, resolvingAgainstBaseURL: false)?.pathComponents, ["a", "b", "c"])
        XCTAssertEqual(URLComponents(url: URL(string: "https://foo.bar/a/b/c")!, resolvingAgainstBaseURL: false)?.pathComponents, ["a", "b", "c"])
        XCTAssertEqual(URLComponents(url: URL(string: "https://foo.bar/a/b/c/")!, resolvingAgainstBaseURL: false)?.pathComponents, ["a", "b", "c"])
        XCTAssertEqual(URLComponents(url: URL(string: "https://foo.bar/a/b/c/?")!, resolvingAgainstBaseURL: false)?.pathComponents, ["a", "b", "c"])
        XCTAssertEqual(URLComponents(url: URL(string: "https://foo.bar/a/b/c/?o=1")!, resolvingAgainstBaseURL: false)?.pathComponents, ["a", "b", "c"])
        XCTAssertEqual(URLComponents(url: URL(string: "https://foo.bar/")!, resolvingAgainstBaseURL: false)?.pathComponents, [])
        XCTAssertEqual(URLComponents(url: URL(string: "https://foo.bar")!, resolvingAgainstBaseURL: false)?.pathComponents, [])
    }

}
#endif
