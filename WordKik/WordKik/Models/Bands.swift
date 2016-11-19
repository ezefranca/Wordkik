//
//  Bands.swift
//
//  Created by Ezequiel on 18/11/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class Bands: Mappable {
    
    public var bands: [Band]?

    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        bands <- map["bands"]
    }
}
