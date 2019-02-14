//
//  Encodable+JSON.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension Encodable {
    
    /**
     Encodes the receiver to JSON data.
     
     - parameter encoder: The JSON encoder.
     - throws: Any error produced by the JSON encoder.
     - returns: JSON data representation of the receiver.
     **/
    
    public func json(using encoder: JSONEncoder) throws -> Data {
        
        return try encoder.encode(self)
    }
    
    /**
     Encodes the receiver to JSON string.
     
     - parameter encoder: The JSON encoder.
     - parameter encoding: The string encoding. Default to UTF-8.
     - throws: Any error produced by the JSON encoder.
     - returns: JSON string representation of the receiver.
     **/
    
    public func json(using encoder: JSONEncoder, encoding: String.Encoding = .utf8) throws -> String {
        
        let data: Data = try self.json(using: encoder)
        guard let string = String(data: data, encoding: encoding) else {
            
            throw EncodingError.invalidValue(data, EncodingError.Context(codingPath: [], debugDescription: "Could not conver the encoded data to String."))
        }
        
        return string
    }
    
    /**
     Encodes the receiver to JSON object.
     
     - parameter encoder: The JSON encoder.
     - parameter options: Options for reading the JSON data and creating the Foundation objects.
     - throws: Any error produced by the JSON encoder or JSONSerialization.
     - returns: JSON object representation of the receiver.
     - note: This method uses the JSONSerialization API to produce the JSON object from the receiver's data.
     - seealso: JSONSerialization.jsonObject(with:options:)
     **/
    
    public func json(using encoder: JSONEncoder, options: JSONSerialization.ReadingOptions) throws -> Any {
        
        let data: Data = try self.json(using: encoder)
        return try JSONSerialization.jsonObject(with: data, options: options)
    }
}


extension Encodable {
    
    /**
     Encodes the receiver to JSON data.
     
     - returns: JSON data representation of the receiver.
     - note: Any errors are ignored and printed to the console.
     **/
    
    public func json() -> Data? {
        
        do {
            
            return try self.json(using: JSONEncoder())
        }
        catch {
            
            print(error)
            return nil
        }
    }

    /**
     Encodes the receiver to JSON string.
     
     - parameter encoding: The string encoding. Default to UTF-8.
     - returns: JSON string representation of the receiver.
     - note: Any errors are ignored and printed to the console.
     **/
    
    public func json(encoding: String.Encoding = .utf8) -> String? {

        do {
            
            return try self.json(using: JSONEncoder(), encoding: encoding)
        }
        catch {
            
            print(error)
            return nil
        }
    }

    /**
     Encodes the receiver to JSON object or array.
     
     - parameter options: Options for reading the JSON data and creating the Foundation objects. Default to [].
     - returns: JSON string representation of the receiver.
     - note: This method uses the JSONSerialization API to produce the JSON object from the receiver's data.
     - note: Any errors are ignored and printed to the console.
     **/
    
    public func json(options: JSONSerialization.ReadingOptions = []) -> Any? {

        do {
            
            return try self.json(using: JSONEncoder(), options: options)
        }
        catch {
            
            print(error)
            return nil
        }
    }
}

extension Encodable {
    
    ///JSON data representation of the receiver
    public var jsonData: Data? {
        
        return self.json()
    }


    ///JSON string representation of the receiver
    public var jsonString: String? {

        return self.json()
    }

    
    ///JSON object or array representation of the receiver
    public var jsonObject: Any? {

        return self.json()
    }
}

