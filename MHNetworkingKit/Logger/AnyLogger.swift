//
//  AnyLogger.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 10.06.21.
//  Copyright © 2021 Milen Halachev. All rights reserved.
//

import Foundation

public struct AnyLogger: Logger {
    
    public let handler: (Error) -> Void
    
    public func log(_ error: Error) { handler(error) }
}

extension Logger where Self == AnyLogger {
    
    ///Returns an instance of the default logger
    public static func any(_ handler: @escaping (Error) -> Void) -> Self { .init(handler: handler) }
}
