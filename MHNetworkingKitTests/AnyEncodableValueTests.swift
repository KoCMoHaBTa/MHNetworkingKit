//
//  AnyEncodableValueTests.swift
//  MHNetworkingKitTests
//
//  Created by Milen Halachev on 24.07.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if !os(watchOS)
import Foundation
import XCTest
@testable import MHNetworkingKit

class AnyEncodableValueTests: XCTestCase {
    
    func testObjectWithAnyEncodablePrimitives() {
        
        struct Mock: Encodable {
            
            var myNil: AnyEncodableValue? = nil
            var myOtherNil: AnyEncodableValue = AnyEncodableValue(value: nil)
            var myString: AnyEncodableValue = "gg"
            var myInt: AnyEncodableValue = AnyEncodableValue(value: Int(5))
            var myFloat: AnyEncodableValue = AnyEncodableValue(value: Float(1.23))
            var myDouble: AnyEncodableValue = AnyEncodableValue(value: Double(3.21))
            var myDate: AnyEncodableValue = AnyEncodableValue(value: Date.init(timeIntervalSince1970: 333))
            var myURL: AnyEncodableValue = AnyEncodableValue(value: URL(string: "https://my.domain.com"))
            var myBool: AnyEncodableValue = true
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        let json: Data = try! Mock().json(using: encoder)
        let dict = try! JSONSerialization.jsonObject(with: json, options: []) as! [String: Any]
        
        XCTAssertEqual(dict.count, 8)
        XCTAssertNil(dict["myNil"])
        XCTAssertEqual(dict["myOtherNil"] as? NSNull, NSNull())
        XCTAssertEqual(dict["myString"] as? String, "gg")
        XCTAssertEqual(dict["myInt"] as? Int, 5)
        XCTAssertEqual(dict["myFloat"] as? Float, 1.23)
        XCTAssertEqual(dict["myDouble"] as? Double, 3.21)
        XCTAssertEqual(dict["myDate"] as? Int, 333)
        XCTAssertEqual(dict["myURL"] as? String, "https://my.domain.com")
        XCTAssertEqual(dict["myBool"] as? Bool, true)
    }
    
    func testArrayWithAnyEncodablePrimitives() {
        
        let mock: [AnyEncodableValue] = [
            AnyEncodableValue(value: nil),
            "gg",
            AnyEncodableValue(value: Int(5)),
            AnyEncodableValue(value: Float(1.23)),
            AnyEncodableValue(value: Double(3.21)),
            AnyEncodableValue(value: Date.init(timeIntervalSince1970: 333)),
            AnyEncodableValue(value: URL(string: "https://my.domain.com")),
            true
        ]
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        let json: Data = try! mock.json(using: encoder)
        let array = try! JSONSerialization.jsonObject(with: json, options: []) as! [Any]
        
        XCTAssertEqual(array.count, 8)
        XCTAssertEqual(array[0] as? NSNull, NSNull())
        XCTAssertEqual(array[1] as? String, "gg")
        XCTAssertEqual(array[2] as? Int, 5)
        XCTAssertEqual(array[3] as? Float, 1.23)
        XCTAssertEqual(array[4] as? Double, 3.21)
        XCTAssertEqual(array[5] as? Int, 333)
        XCTAssertEqual(array[6] as? String, "https://my.domain.com")
        XCTAssertEqual(array[7] as? Bool, true)
    }
    
    func testAnyEncodableContainingObject() {
        
        //not supported yet
    }
    
    func testAnyEncodableContainingArray() {
        
        //not supported yet
    }
    
    func testAnyEncodableContainingAnyEncodable() {
        
        //not supported yet
    }
    
    func testNestedObjects() {
        
        //not supported
        
//        struct Mock: Encodable {
//
//            var myObject: NestedObj1 = NestedObj1()
//            var myArray: [NestedObj1] = [NestedObj1(), NestedObj1()]
//            var myAnyObject: AnyEncodableValue = AnyEncodableValue(value: NestedObj1())
//            var myAntArray: [AnyEncodableValue] = [AnyEncodableValue(value: NestedObj1()), AnyEncodableValue(value: NestedObj1())]
//        }
//
//        struct NestedObj1: Encodable {
//
//            var myAnyString: AnyEncodableValue = "gg"
//            var myString = "zz"
//            var arr: [Int] = [1, 3, 2]
//        }
//
//        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .secondsSince1970
//        let json: Data = try! Mock().json(using: encoder)
//        let dict = try! JSONSerialization.jsonObject(with: json, options: []) as! [String: Any]
//
//        XCTAssertEqual(dict.count, 4)
//        XCTAssertEqual(dict["myObject"] as? [String: AnyHashable], ["myAnyString": "gg", "myString": "zz", "arr": [1, 3, 2]])
    }
}
#endif
