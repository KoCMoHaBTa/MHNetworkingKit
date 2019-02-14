//
//  URLRequest+HTTPMethod.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension URLRequest {
    
    ///HTTP method
    ///
    ///[Online Reference](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html)
    public enum HTTPMethod: String {
        
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        case head = "HEAD"
        case options = "OPTIONS"
        case trace = "TRACE"
        case connect = "CONNECT"
    }
    
    public var method: HTTPMethod? {
        
        get {
            
            guard let httpMethod = self.httpMethod else { return nil }
            let method = HTTPMethod(rawValue: httpMethod)
            return method
        }
        
        set {
            
            self.httpMethod = newValue?.rawValue
        }
    }
}

extension URLRequest {
    
    public init(url: URL, method: HTTPMethod) {
        
        self.init(url: url)
        
        self.method = method
    }
    
    public init(url: URL, method: HTTPMethod, contentType: String?, body: Data?) {
        
        self.init(url: url, method: method)
        
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        self.httpBody = body
    }
    
    public init(url: URL, cachePolicy: CachePolicy, timeoutInterval: TimeInterval, method: HTTPMethod) {
        
        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        
        self.method = method
    }
    
    public init(url: URL, cachePolicy: CachePolicy, timeoutInterval: TimeInterval, method: HTTPMethod, contentType: String?, body: Data?) {
        
        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval, method: method)
        
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        self.httpBody = body
    }
}
