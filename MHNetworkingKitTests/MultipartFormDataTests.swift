//
//  MultipartFormDataTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import Foundation
import XCTest
@testable import MHNetworkingKit

class MultipartFormDataTests: XCTestCase {
    
    //when no parts are provided - produces empty data
    func testNoParts() {
        
        let multipart = MultipartFormData(parts: [])
        XCTAssertEqual(multipart.data, Data())
    }
    
    func testSinglePart() {
        
        let expectedResult =
        """
        --812dfde1-e9eb-447c-a4e7-e19d3a32290a
        Content-Disposition: form-data; name="gg"; filename="gg.txt"
        Content-Type: text/plain

        123ABC
        --812dfde1-e9eb-447c-a4e7-e19d3a32290a--
        """

        var multipart = MultipartFormData(part: MultipartFormData.Part(data: "123ABC".data(using: .utf8)!, contentType: "text/plain", name: "gg", fileName: "gg.txt"))
        multipart.boundary = "812dfde1-e9eb-447c-a4e7-e19d3a32290a"
        multipart.lineEnding = "\n"
        
        let data = multipart.data
        let string = String(data: data, encoding: .utf8)
        
        XCTAssertEqual(expectedResult, string)
    }
    
    func testMultipleParts() {
        
        let expectedResult =
        """
        --812dfde1-e9eb-447c-a4e7-e19d3a32290a
        Content-Disposition: form-data; name="gg"; filename="gg.txt"
        Content-Type: text/plain

        123ABC
        --812dfde1-e9eb-447c-a4e7-e19d3a32290a
        Content-Disposition: form-data; name="gson"; filename="omg.json"
        Content-Type: application/json

        {"value":123}
        --812dfde1-e9eb-447c-a4e7-e19d3a32290a
        Content-Disposition: form-data; name="snimka"; filename="omg.png"
        Content-Type: image/png

        lkjaskjldakljfjkdah
        --812dfde1-e9eb-447c-a4e7-e19d3a32290a--
        """
        
        let parts = [
            
            MultipartFormData.Part(data: "123ABC".data(using: .utf8)!, contentType: "text/plain", name: "gg", fileName: "gg.txt"),
            MultipartFormData.Part(data: try! JSONSerialization.data(withJSONObject: ["value": 123], options: []), contentType: "application/json", name: "gson", fileName: "omg.json"),
            MultipartFormData.Part(data: "lkjaskjldakljfjkdah".data(using: .utf8)!, contentType: "image/png", name: "snimka", fileName: "omg.png")
        ]
        
        var multipart = MultipartFormData(parts: parts)
        multipart.boundary = "812dfde1-e9eb-447c-a4e7-e19d3a32290a"
        multipart.lineEnding = "\n"
        
        let data = multipart.data
        let string = String(data: data, encoding: .utf8)
        
        XCTAssertEqual(expectedResult, string)
    }
}
#endif
