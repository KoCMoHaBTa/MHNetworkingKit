//
//  URLComponents+PathComponents.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 18.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

//Weird enough - URLComponents does not have its own pathComponents property, and URL returns inappropriate pathComponents.
//This looks like the best place to return the correct pathComponents.
extension URLComponents {
    
    public var pathComponents: [String]? {
        
        return self.url?.pathComponents.filter { (pathComponent) -> Bool in
            
            let pathComponent = pathComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !pathComponent.isEmpty else {
                
                return false
            }
            
            return pathComponent != "/"
            
        }
    }
}
