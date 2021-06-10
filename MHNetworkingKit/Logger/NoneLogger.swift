//
//  NoneLogger.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 10.06.21.
//  Copyright © 2021 Milen Halachev. All rights reserved.
//

import Foundation

public struct NoneLogger: Logger {
    
    public func log(_ error: Error) {}
}

extension Logger where Self == NoneLogger {
    
    ///Returns an instance of the default logger
    public static var none: Self { .init() }
}
