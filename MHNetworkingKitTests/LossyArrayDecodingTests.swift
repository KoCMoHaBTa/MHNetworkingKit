//
//  LossyArrayDecodingTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 27.09.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHNetworkingKit

class LossyArrayDecodingTests: XCTestCase {
    
    struct OptionalArrayModel: Codable {
        
        var name: String
        var arr: [String]?
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.name = try container.decode(forKey: .name)
            self.arr = try? container.decodeLossyArray(forKey: .arr)
        }
        
        enum CodingKeys: String, CodingKey {
            
            case name
            case arr
        }
    }
    
    struct RequiredArrayModel: Codable {
        
        var name: String
        var arr: [String]
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.name = try container.decode(forKey: .name)
            self.arr = try container.decodeLossyArray(forKey: .arr)
        }
        
        enum CodingKeys: String, CodingKey {
            
            case name
            case arr
        }
    }
    
    let missingArrayJSON =  """
                            {"name": "missingArrayJSON"}
                            """
    
    let nullArrayJSON = """
                        {"name": "nullArrayJSON", "arr": null}
                        """
    
    let validArrayJSON = """
                         {"name": "validArrayJSON", "arr": ["a", "b"]}
                         """
    
    let invalidArrayJSON =  """
                            {"name": "invalidArrayJSON", "arr": ["a", 1, "b"]}
                            """
    
    //when decoding optional array - if the array is not present - the result array should be nil
    func testOptionalMissingArrayDecoding() {
        
        let model = OptionalArrayModel(json: missingArrayJSON)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "missingArrayJSON")
        XCTAssertNil(model?.arr)
    }
    
    //when decoding optional array - if the array is null - the result array should be nil
    func testOptionalNullArrayDecoding() {
        
        let model = OptionalArrayModel(json: nullArrayJSON)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "nullArrayJSON")
        XCTAssertNil(model?.arr)
    }
    
    //when decoding optional array - if the array is valid - the result array should be the valid array
    func testOptionalValidArrayDecoding() {
        
        let model = OptionalArrayModel(json: validArrayJSON)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "validArrayJSON")
        XCTAssertEqual(model?.arr, ["a", "b"])
    }
    
    //when decoding optional array - if the array is invalid - the result array should be the array, containing only the valid elements
    func testOptionalInvalidArrayDecoding() {
        
        let model = OptionalArrayModel(json: invalidArrayJSON)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalidArrayJSON")
        XCTAssertEqual(model?.arr, ["a", "b"])
    }
    
    //when decoding required array - if the array is not present - an exception should be thrown, leading to invalid model
    func testRequiredMissingArrayDecoding() {
        
        let model = RequiredArrayModel(json: missingArrayJSON)
        
        XCTAssertNil(model)
    }
    
    //when decoding required array - if the array is null - an exception should be thrown, leading to invalid model
    func testRequiredNullArrayDecoding() {
        
        let model = RequiredArrayModel(json: nullArrayJSON)
        
        XCTAssertNil(model)
    }
    
    //when decoding required array - if the array is valid - the result array should be the valid array
    func testRequiredValidArrayDecoding() {
        
        let model = RequiredArrayModel(json: validArrayJSON)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "validArrayJSON")
        XCTAssertEqual(model?.arr, ["a", "b"])
    }
    
    //when decoding required array - if the array is invalid - the result array should be the array, containing only the valid elements
    func testRequiredInvalidArrayDecoding() {
        
        let model = RequiredArrayModel(json: invalidArrayJSON)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalidArrayJSON")
        XCTAssertEqual(model?.arr, ["a", "b"])
    }
}
