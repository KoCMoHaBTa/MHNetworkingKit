//
//  URL+QueryOperator.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

public func +(lhs: URL, rhs: String) -> URL {
    
    return lhs.appendingPathComponent(rhs)
}

infix operator +? : AdditionPrecedence
public func +?(lhs: URL, rhs: [String: Any]) -> URL? {
    
    var components = URLComponents(url: lhs, resolvingAgainstBaseURL: true)
    components?.percentEncodedQuery = rhs.urlEncodedParametersString
    
    return components?.url
}

infix operator +?! : AdditionPrecedence
public func +?!(lhs: URL, rhs: [String: Any]) -> URL {
    
    return (lhs +? rhs)!
}
