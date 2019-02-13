//
//  String+URLEncoding.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension String {
    
    var urlDecodedParameters: [String: String] {
        
        let pairs = self.components(separatedBy: "&")
        let parameters = pairs.reduce([:]) { (result, pair) -> [String: String] in
            
            let components = pair.components(separatedBy: "=")
            
            guard
            components.count == 2,
            let key = components.first?.removingPercentEncoding,
            let value = components.last?.removingPercentEncoding
            else {
                
                 return result
            }
            
            var result = result
            result[key] = value
            return result
        }
        
        return parameters
    }
}
