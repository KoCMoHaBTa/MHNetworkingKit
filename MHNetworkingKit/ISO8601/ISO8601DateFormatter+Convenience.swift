//
//  ISO8601DateFormatter+Convenience.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 28.04.21.
//  Copyright © 2021 Milen Halachev. All rights reserved.
//

import Foundation

@available(iOS 10.0, *)
extension ISO8601DateFormatter {
    
    public convenience init(formatOptions: Options, timeZone: TimeZone) {
        
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
    
    public convenience init(formatOptions: Options) {
        
        self.init()
        self.formatOptions = formatOptions
    }
    
    public convenience init(timeZone: TimeZone) {
        
        self.init()
        self.timeZone = timeZone
    }
}
