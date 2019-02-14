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
    public struct HTTPMethod: RawRepresentable, ExpressibleByStringLiteral {
        
        public var rawValue: String
        
        public init?(rawValue: String) { self.rawValue = rawValue }
        public init(stringLiteral value: String) { self.rawValue = value }
        public init(unicodeScalarLiteral value: String) { self.rawValue = value }
        public init(extendedGraphemeClusterLiteral value: String) { self.rawValue = value }
        
        public static var get: HTTPMethod = "GET"
        public static var put: HTTPMethod = "PUT"
        public static var post: HTTPMethod = "POST"
        public static var delete: HTTPMethod = "DELETE"
        public static var head: HTTPMethod = "HEAD"
        public static var options: HTTPMethod = "OPTIONS"
        public static var trace: HTTPMethod = "TRACE"
        public static var connect: HTTPMethod = "CONNECT"
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
