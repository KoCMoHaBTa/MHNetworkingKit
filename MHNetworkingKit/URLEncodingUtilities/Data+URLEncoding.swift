//
//  Data+URLEncoding.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension Data {
    
    var urlDecodedParameters: [String: String]? {
        
        return String(data: self, encoding: .utf8)?.urlDecodedParameters
    }
}
