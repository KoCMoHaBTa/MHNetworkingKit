//
//  DefaultLogger.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 10.06.21.
//  Copyright © 2021 Milen Halachev. All rights reserved.
//

import Foundation

///Default Logger provided by the library
public struct DefaultLogger: Logger {
    
    public func log(_ error: Error) { print(error) }
}

extension Logger where Self == DefaultLogger {
    
    ///Returns an instance of the default logger
    public static var `default`: Self { .init() }
}
