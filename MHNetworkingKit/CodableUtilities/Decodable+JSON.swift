//
//  Decodable+JSON.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 14.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension Decodable {
    
    /**
     Creates an instance of the receiver from a JSON data, using a given JSON decoder.
     
     - parameter data: The JSON data.
     - parameter decoder: The JSON decoder.
     - throws: Any error produced by the JSON decoder.
     - returns: An isntance of the receiver.
     **/
    
    public init(json data: Data, using decoder: JSONDecoder) throws {
        
        self = try decoder.decode(Self.self, from: data)
    }
    
    /**
     Creates an instance of the receiver from a JSON string, using a given JSON decoder and string encoding.
     
     - parameter string: The JSON string.
     - parameter decoder: The JSON decoder.
     - parameter encoding: The string encoding to use. Default to UTF-8.
     - throws: Any error produced by the JSON decoder.
     - returns: An isntance of the receiver.
     **/
    
    public init(json string: String, using decoder: JSONDecoder, encoding: String.Encoding = .utf8) throws {
        
        guard let data = string.data(using: encoding) else {
            
            throw DecodingError.dataCorrupted(DecodingError.Context.init(codingPath: [], debugDescription: "Cannot convert the received string to data"))
        }
        
        self = try decoder.decode(Self.self, from: data)
    }
    
    /**
     Creates an instance of the receiver from a JSON object or array, using a given JSON decoder.
     
     
     
     - parameter object: The JSON object or array.
     - parameter decoder: The JSON decoder.
     - parameter encoding: The string encoding to use. Default to UTF-8.
     - throws: Any error produced by the JSON decoder or JSONSerialization.
     - returns: An isntance of the receiver.
     - note: This method uses the JSONSerialization API to produce the JSON data from the supplied object.
     - seealso: JSONSerialization.data(withJSONObject:options:)
     **/
    
    public init(json object: Any, using decoder: JSONDecoder, options: JSONSerialization.WritingOptions) throws {
        
        let data = try JSONSerialization.data(withJSONObject: object, options: options)
        try self.init(json: data, using: decoder)
    }
}

extension Decodable {

    /**
     Creates an instance of the receiver from a JSON data.
     
     - parameter data: The JSON data.
     - parameter logger: A logger used to log errors. Default logger prints to console.
     - returns: An isntance of the receiver or nil if decoding fails or data is nil.
     - note: Any errors are ignored and printed to the console.
     **/
    
    public init?(json data: Data?, logger: Logger = DefaultLogger()) {

        guard let data = data else {

            return nil
        }

        do {

            try self.init(json: data, using: JSONDecoder())
        }
        catch {

            logger.log(error)
            return nil
        }
    }

    /**
     Creates an instance of the receiver from a JSON string.
     
     - parameter string: The JSON string.
     - parameter encoding: The string encoding to use. Default to UTF-8.
     - parameter logger: A logger used to log errors. Default logger prints to console.
     - returns: An isntance of the receiver or nil if decoding fails or string is nil.
     - note: Any errors are ignored and printed to the console.
     **/
    
    public init?(json string: String?, encoding: String.Encoding = .utf8, logger: Logger = DefaultLogger()) {
        
        guard let string = string else {
            
            return nil
        }
        
        do {
            
            try self.init(json: string, using: JSONDecoder(), encoding: encoding)
        }
        catch {
            
            logger.log(error)
            return nil
        }
    }

    /**
     Creates an instance of the receiver from a JSON object or array.
     
     - parameter object: The JSON object or array.
     - parameter options: The JSONSerialization options for creating the JSON data. Default to [].
     - parameter logger: A logger used to log errors. Default logger prints to console.
     - returns: An isntance of the receiver or nil if decoding fails or object is nil.
     - note: This method uses the JSONSerialization API to produce the JSON data from the supplied object.
     - note: Any errors are ignored and printed to the console.
     **/
    
    public init?(json object: Any?, options: JSONSerialization.WritingOptions = [], logger: Logger = DefaultLogger()) {
        
        guard let object = object else {
            
            return nil
        }
        
        do {
            
            try self.init(json: object, using: JSONDecoder(), options: options)
        }
        catch {
            
            logger.log(error)
            return nil
        }
    }
}
