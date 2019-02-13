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

extension MultipartFormData {
    
    public struct Part {
        
        ///The binary data of the part.
        public let data: Data
        
        ///The value of the `Content-Type` header of the part
        public let contentType: String
        
        ///The value of the `name` parameter in the `Content-Disposition` header section of the part.
        public let name: String
        
        ///The value of the `filename` parameter in the `Content-Disposition` header section of the part.
        public let fileName: String
        
        public init(data: Data, contentType: String, name: String, fileName: String) {
            
            self.data = data
            self.contentType = contentType
            self.name = name
            self.fileName = fileName
        }
        
        ///Creates an instance of the receiver with the provided data. The name is set to random UUID
        public init(data: Data, contentType: String, fileName: String) {

            self.init(data: data, contentType: contentType, name: UUID().uuidString, fileName: fileName)
        }

        ///Creates an instance of the receiver with the provided data. The name and fileName are set to random UUID
        public init(data: Data, contentType: String) {

            self.init(data: data, contentType: contentType, name: UUID().uuidString, fileName: UUID().uuidString)
        }
        
        ///Creates an instance of the receiver with the provided data. The content type is set to `application/octet-stream` and the name and fileName are set to random GUID
        public init(data: Data) {
            
            self.init(data: data, contentType: "application/octet-stream", name: UUID().uuidString, fileName: UUID().uuidString)
        }
    }
}
