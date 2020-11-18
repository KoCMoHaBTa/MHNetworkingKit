//
//  Codable+JSONFile.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 18.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

extension Decodable {
    
    public init(JSONContentsOf url: URL, options: Data.ReadingOptions = [], using decoder: JSONDecoder = .init()) throws {
        
        let data = try Data(contentsOf: url, options: options)
        
        do {
            
            try self.init(json: data, using: decoder)
        }
        catch {
            
            //JSONDecoder does not support fragments decoding prior iOS 13, so we fallback to JSONSerialization
            guard let value = try JSONSerialization.jsonObject(with: Data(contentsOf: url), options: [.fragmentsAllowed]) as? Self else {
                
                throw error
            }
            
            self = value
        }
    }
}

extension Encodable {
    
    public func writeJSON(to url: URL, options: Data.WritingOptions = [], using encoder: JSONEncoder = .init()) throws {
        
        
        let data: Data
        
        do {
         
            data = try self.json(using: encoder)
        }
        catch {
            
            //JSONEncoder does not support fragments encoding prior iOS 13, so we fallback to JSONSerialization
            data = try JSONSerialization.data(withJSONObject: self, options: [.fragmentsAllowed])
        }
        
        try data.write(to: url, options: options)
    }
}
