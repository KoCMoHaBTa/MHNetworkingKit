//
//  MultipartFormData.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

public struct MultipartFormData {
    
    ///The boundary of the form data. Default to random UUID.
    public var boundary: String = "---------------------" + UUID().uuidString + "---------------------"
    
    ///The line ending of the form data. Default to `\r\n`
    public var lineEnding: String = "\r\n"
    
    ///The parts, used to build the form data.
    public var parts: [Part] = []
    
    ///Creates an instance of the receiver with a single part
    public init(parts: [Part]) {
        
        self.parts = parts
    }
    
    ///Creates an instance of the receiver with multiple parts
    public init(part: Part) {
        
        self.init(parts: [part])
    }
    
    ///Computes the combined data of all parts and returns the result.
    public var data: Data {
        
        //if there are no parts - return empty data
        guard self.parts.isEmpty == false else {
            
            return Data()
        }
        
        let boundary = "--\(self.boundary)".data(using: .utf8)!     //preppend -- to the boundary - MIME standart
        let lineEnding = self.lineEnding.data(using: .utf8)!
        
        var data = self.parts.reduce(into: Data(), { (data, part) in
            
            let contentDisposition = "Content-Disposition: form-data; name=\"\(part.name)\"; filename=\"\(part.fileName)\"".data(using: .utf8)!
            let contentType = "Content-Type: \(part.contentType)".data(using: .utf8)!
            
            data.append(boundary)
            data.append(lineEnding)
            data.append(contentDisposition)
            data.append(lineEnding)
            data.append(contentType)
            data.append(lineEnding)
            data.append(lineEnding)             //extra line
            data.append(part.data)
            data.append(lineEnding)
        })
        
        data.append(boundary)                   //append the last boundar
        data.append("--".data(using: .utf8)!)   //append -- to the last boundary - MIME standart
        
        return data
    }
}

