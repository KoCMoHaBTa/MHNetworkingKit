//
//  LossyDecodingTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 25.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import Foundation
import XCTest
@testable import MHNetworkingKit

class LossyDecodingTests: XCTestCase {
    
    struct Model {
        
        struct Nested: Codable, Hashable {
            
            var foo: String
            
            init(_ foo: String) {
                
                self.foo = foo
            }
        }
        
        struct Primitive {
            
            struct Optional: Codable {
                
                var name: String
                @LossyDecoded var array: [String]?
                @LossyDecoded var set: Set<String>?
                @LossyDecoded var dictionary: [String: String]?
                @LossyDecoded var value: String?
            }
            
            struct Required: Codable {
                
                var name: String
                @LossyDecoded var array: [String]
                @LossyDecoded var set: Set<String>
                @LossyDecoded var dictionary: [String: String]
            }
        }
        
        struct Complex {
         
            struct Optional: Codable {
                
                var name: String
                @LossyDecoded var array: [Nested]?
                @LossyDecoded var set: Set<Nested>?
                @LossyDecoded var dictionary: [String: Nested]?
                @LossyDecoded var value: Nested?
            }
            
            struct Required: Codable {
                
                var name: String
                @LossyDecoded var array: [Nested]
                @LossyDecoded var set: Set<Nested>
                @LossyDecoded var dictionary: [String: Nested]
            }
        }
    }
    
    struct JSON {
        
        struct Primitive {
         
            static let missing =  """
                                    {"name": "missing"}
                                    """
            
            static let null = """
                                {"name": "null", "array": null, "set": null, "dictionary": null, "value": null}
                                """
            
            static let valid = """
                                 {"name": "valid", "array": ["a", "b"], "set": ["a", "b"], "dictionary": {"A": "a", "B": "b"}, "value": "a"}
                                 """
            
            static let invalid =  """
                                    {"name": "invalid", "array": ["a", 1, "b"], "set": ["a", 1, "b"], "dictionary": {"A": "a", "invalid": 1, "B": "b"}, "value": 1}
                                    """
        }
        
        struct Complex {
         
            static let missing =  """
                                    {"name": "missing"}
                                    """
            
            static let null = """
                                {"name": "null", "array": null, "set": null, "dictionary": null, "value": null}
                                """
            
            static let valid = """
                                 {"name": "valid", "array": [{"foo": "a"}, {"foo": "b"}], "set": [{"foo": "a"}, {"foo": "b"}], "dictionary": {"A": {"foo": "a"}, "B": {"foo": "b"}}, "value": {"foo": "a"}}
                                 """
            
            static let invalid =  """
                                     {"name": "invalid", "array": [{"foo": "a"}, 1, {"foo": "b"}], "set": [{"foo": "a"}, 1, {"foo": "b"}], "dictionary": {"A": {"foo": "a"}, "invalid": 1, "B": {"foo": "b"}}, "value": 1}
                                    """
            
            static let invalidNested =  """
                                         {"name": "invalidNested", "array": [{"foo": "a"}, {"foo": 1}, {"foo": "b"}], "set": [{"foo": "a"}, {"foo": 1}, {"foo": "b"}], "dictionary": {"A": {"foo": "a"}, "invalid": {"foo": 1}, "B": {"foo": "b"}}, "value": {"foo": 1}}
                                        """
        }
    }
    
    //MARK: - Primitive Optional
    
    func testPrimitiveOptionalMissing() {
        
        let model = Model.Primitive.Optional(json: JSON.Primitive.missing)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "missing")
        XCTAssertNil(model?.array)
        XCTAssertNil(model?.set)
        XCTAssertNil(model?.dictionary)
        XCTAssertNil(model?.value)
    }
    
    func testPrimitiveOptionalNull() {
        
        let model = Model.Primitive.Optional(json: JSON.Primitive.null)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "null")
        XCTAssertNil(model?.array)
        XCTAssertNil(model?.set)
        XCTAssertNil(model?.dictionary)
        XCTAssertNil(model?.value)
    }
    
    func testPrimitiveOptionalValid() {
        
        let model = Model.Primitive.Optional(json: JSON.Primitive.valid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "valid")
        XCTAssertEqual(model?.array, ["a", "b"])
        XCTAssertEqual(model?.set, ["a", "b"])
        XCTAssertEqual(model?.dictionary, ["A": "a", "B": "b"])
        XCTAssertEqual(model?.value, "a")
    }
    
    func testPrimitiveOptionalInvalid() {
        
        let model = Model.Primitive.Optional(json: JSON.Primitive.invalid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalid")
        XCTAssertEqual(model?.array, ["a", "b"])
        XCTAssertEqual(model?.set, ["a", "b"])
        XCTAssertEqual(model?.dictionary, ["A": "a", "B": "b"])
        XCTAssertNil(model?.value)
    }
    
    //MARK: - Complex Optional
    
    func testComplexOptionalMissing() {
        
        let model = Model.Complex.Optional(json: JSON.Complex.missing)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "missing")
        XCTAssertNil(model?.array)
        XCTAssertNil(model?.set)
        XCTAssertNil(model?.dictionary)
        XCTAssertNil(model?.value)
    }
    
    func testComplexOptionalNull() {
        
        let model = Model.Complex.Optional(json: JSON.Complex.null)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "null")
        XCTAssertNil(model?.array)
        XCTAssertNil(model?.set)
        XCTAssertNil(model?.dictionary)
        XCTAssertNil(model?.value)
    }
    
    func testComplexOptionalValid() {
        
        let model = Model.Complex.Optional(json: JSON.Complex.valid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "valid")
        XCTAssertEqual(model?.array, [.init("a"), .init("b")])
        XCTAssertEqual(model?.set, [.init("a"), .init("b")])
        XCTAssertEqual(model?.dictionary, ["A": .init("a"), "B": .init("b")])
        XCTAssertEqual(model?.value, .init("a"))
    }
    
    func testComplexOptionalInvalid() {
        
        let model = Model.Complex.Optional(json: JSON.Complex.invalid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalid")
        XCTAssertEqual(model?.array, [.init("a"), .init("b")])
        XCTAssertEqual(model?.set, [.init("a"), .init("b")])
        XCTAssertEqual(model?.dictionary, ["A": .init("a"), "B": .init("b")])
        XCTAssertNil(model?.value)
    }
    
    func testComplexOptionalInvalidNested() {
        
        let model = Model.Complex.Optional(json: JSON.Complex.invalidNested)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalidNested")
        XCTAssertEqual(model?.array, [.init("a"), .init("b")])
        XCTAssertEqual(model?.set, [.init("a"), .init("b")])
        XCTAssertEqual(model?.dictionary, ["A": .init("a"), "B": .init("b")])
        XCTAssertNil(model?.value)
    }
    
    //MARK: - Primitive Required
    
    func testPrimitiveRequiredMissing() {
        
        let model = Model.Primitive.Required(json: JSON.Primitive.missing)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "missing")
        XCTAssertEqual(model?.array, [])
        XCTAssertEqual(model?.set, [])
        XCTAssertEqual(model?.dictionary, [:])
    }
    
    func testPrimitiveRequiredNull() {
        
        let model = Model.Primitive.Required(json: JSON.Primitive.null)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "null")
        XCTAssertEqual(model?.array, [])
        XCTAssertEqual(model?.set, [])
        XCTAssertEqual(model?.dictionary, [:])
    }
    
    func testPrimitiveRequiredValid() {
        
        let model = Model.Primitive.Required(json: JSON.Primitive.valid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "valid")
        XCTAssertEqual(model?.array, ["a", "b"])
        XCTAssertEqual(model?.set, ["a", "b"])
        XCTAssertEqual(model?.dictionary, ["A": "a", "B": "b"])
    }
    
    func testPrimitiveRequiredInvalid() {
        
        let model = Model.Primitive.Required(json: JSON.Primitive.invalid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalid")
        XCTAssertEqual(model?.array, ["a", "b"])
        XCTAssertEqual(model?.set, ["a", "b"])
        XCTAssertEqual(model?.dictionary, ["A": "a", "B": "b"])
    }
    
    //MARK: - Complex Required
    
    func testComplexRequiredMissing() {
        
        let model = Model.Complex.Required(json: JSON.Complex.missing)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "missing")
        XCTAssertEqual(model?.array, [])
        XCTAssertEqual(model?.set, [])
        XCTAssertEqual(model?.dictionary, [:])
    }
    
    func testComplexRequiredNull() {
        
        let model = Model.Complex.Required(json: JSON.Complex.null)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "null")
        XCTAssertEqual(model?.array, [])
        XCTAssertEqual(model?.set, [])
        XCTAssertEqual(model?.dictionary, [:])
    }
    
    func testComplexRequiredValid() {
        
        let model = Model.Complex.Required(json: JSON.Complex.valid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "valid")
        XCTAssertEqual(model?.array, [.init("a"), .init("b")])
        XCTAssertEqual(model?.set, [.init("a"), .init("b")])
        XCTAssertEqual(model?.dictionary, ["A": .init("a"), "B": .init("b")])
    }
    
    func testComplexRequiredInvalid() {
        
        let model = Model.Complex.Required(json: JSON.Complex.invalid)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalid")
        XCTAssertEqual(model?.array, [.init("a"), .init("b")])
        XCTAssertEqual(model?.set, [.init("a"), .init("b")])
        XCTAssertEqual(model?.dictionary, ["A": .init("a"), "B": .init("b")])
    }
    
    func testComplexRequiredInvalidNested() {
        
        let model = Model.Complex.Required(json: JSON.Complex.invalidNested)
        
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.name, "invalidNested")
        XCTAssertEqual(model?.array, [.init("a"), .init("b")])
        XCTAssertEqual(model?.set, [.init("a"), .init("b")])
        XCTAssertEqual(model?.dictionary, ["A": .init("a"), "B": .init("b")])
    }
}
#endif
