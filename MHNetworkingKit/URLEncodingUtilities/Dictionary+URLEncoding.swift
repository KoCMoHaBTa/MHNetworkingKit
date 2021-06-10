//
//  Dictionary+URLEncoding.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension Dictionary {
    
    private func urlEncode(_ string: String) -> String {
        
        var allowedCharacter = CharacterSet.urlQueryAllowed
        allowedCharacter.remove(charactersIn: "!@#$%&*()+'\";:=,/?[] ")
        
        let result = string.addingPercentEncoding(withAllowedCharacters: allowedCharacter)
        return result ?? string
    }
    
    private func urlEncode(_ object: Any) -> String {
        
        urlEncode(String(describing: object))
    }
    
    public var urlEncodedParametersString: String {
        
        var result = reduce("") { (result, element) -> String in
            
            let key = self.urlEncode(element.key)
            let value = self.urlEncode(element.value)
            
            let result = result + "&" + key + "=" + value
            return result
        }
        
        if !result.isEmpty {
            
            //remove the first `&` character
            let index = result.index(result.startIndex, offsetBy: 1)
            result = String(result[index ..< result.endIndex])
        }
                
        return result
    }
    
    public var urlEncodedParametersData: Data? {
        
        urlEncodedParametersString.data(using: .utf8)
    }
}
