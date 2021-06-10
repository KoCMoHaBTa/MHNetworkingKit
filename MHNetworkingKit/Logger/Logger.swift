//
//  Logger.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 10.06.21.
//  Copyright © 2021 Milen Halachev. All rights reserved.
//

import Foundation

///A type that logs errors
public protocol Logger {
    
    func log(_ error: Error)
}
