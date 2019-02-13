//
//  URLEncodingTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHNetworkingKit

class URLEncodingTests: XCTestCase {
    
    func testDictionaryURLEncodedParameters() {
        
        XCTAssertEqual(["1234567890qwertyuiopasdfghjklzxcvbnm": "alphanumerictest "].urlEncodedParametersString, "1234567890qwertyuiopasdfghjklzxcvbnm=alphanumerictest%20")
        XCTAssertEqual(["!@#$%^&*()_+": "-="].urlEncodedParametersString, "%21%40%23%24%25%5E%26%2A%28%29_%2B=-%3D")
        XCTAssertEqual(["[]\\": "{}|"].urlEncodedParametersString, "%5B%5D%5C=%7B%7D%7C") //  []\ --- {}|
        XCTAssertEqual([";'": ":\""].urlEncodedParametersString, "%3B%27=%3A%22") //;' --- :"
        XCTAssertEqual([",./": "<>?"].urlEncodedParametersString, "%2C.%2F=%3C%3E%3F") //,./ --- <>?
    }
    
    func testStringURLDecoding() {
        
        let string = "1234567890qwertyuiopasdfghjklzxcvbnm=alphanumerictest%20&%21%40%23%24%25%5E%26%2A%28%29_%2B=-%3D&%5B%5D%5C=%7B%7D%7C&%3B%27=%3A%22&%2C.%2F=%3C%3E%3F"
        let expectedDictionary = ["1234567890qwertyuiopasdfghjklzxcvbnm": "alphanumerictest ", "!@#$%^&*()_+": "-=", "[]\\": "{}|", ";'": ":\"", ",./": "<>?"]
        
        XCTAssertEqual(string.urlDecodedParameters, expectedDictionary)
    }
    
    func testURLQueryBuilding() {
        
        XCTAssertEqual(URL(string: "https://google.com")! +?! ["p1": "v1"], URL(string: "https://google.com?p1=v1")!)
        XCTAssertEqual(URL(string: "https://google.com/")! +?! ["p1": "v1"], URL(string: "https://google.com/?p1=v1")!)
        XCTAssertEqual(URL(string: "https://google.com/test/path/doSomething")! +?! ["p1": "v1"], URL(string: "https://google.com/test/path/doSomething?p1=v1")!)
        XCTAssertEqual(URL(string: "https://google.com/test/path/doSomething/")! +?! ["p1": "v1"], URL(string: "https://google.com/test/path/doSomething/?p1=v1")!)
        XCTAssertEqual((URL(string: "https://google.com")! +? ["p1": "v1", "p2": "v2"])?.query?.urlDecodedParameters, ["p1": "v1", "p2": "v2"])
    }
}
