//
//  Data+URLEncoding.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension Data {
    
    public var urlDecodedParameters: [String: String]? {
        
        String(data: self, encoding: .utf8)?.urlDecodedParameters
    }
}
