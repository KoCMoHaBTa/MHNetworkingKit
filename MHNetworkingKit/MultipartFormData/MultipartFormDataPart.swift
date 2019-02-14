//
//  MultipartFormDataPart.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 14.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

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
