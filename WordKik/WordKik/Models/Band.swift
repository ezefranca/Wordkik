//
//  Band.swift
//
//  Created by Ezequiel on 18/11/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class Band: Mappable {
    
    public var identifier: String?
    public var name: String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        identifier <- map["id"]
        name <- map["name"]
    }
}
