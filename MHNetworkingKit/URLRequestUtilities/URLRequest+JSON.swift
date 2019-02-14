//
//  URLRequest+JSON.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 14.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension URLRequest {
    
    public init(url: URL, method: HTTPMethod, json data: Data) {
        
        self.init(url: url, method: method, contentType: "application/json", body: data)
    }
    
    public init<T>(url: URL, method: HTTPMethod, json model: T, using encoder: JSONEncoder) throws where T: Encodable {
        
        self.init(url: url, method: method, contentType: "application/json", body: try model.json(using: encoder))
    }
    
    public init<T>(url: URL, method: HTTPMethod, json model: T) where T: Encodable {
        
        self.init(url: url, method: method, contentType: "application/json", body: model.json())
    }
    
    public init(url: URL, method: HTTPMethod, json object: Any, options: JSONSerialization.WritingOptions) throws {

        self.init(url: url, method: method, contentType: "application/json", body: try JSONSerialization.data(withJSONObject: object, options: options))
    }
    
    public init(url: URL, method: HTTPMethod, json object: Any) {
        
        self.init(url: url, method: method, contentType: "application/json", body: try? JSONSerialization.data(withJSONObject: object, options: []))
    }
}
