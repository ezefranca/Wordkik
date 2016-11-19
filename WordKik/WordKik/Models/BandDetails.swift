//
//  BandDetails.swift
//  WordKik
//
//  Created by Ezequiel on 19/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import Foundation
import ObjectMapper

public class BandDetails: Mappable {
    
    public var name: String?
    public var genre: String?
    public var image: String?
    public var country: String?
    public var country_flag: String?
    public var website: String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        genre <- map["genre"]
        image <- map["image"]
        country <- map["country"]
        country_flag <- map["country_flag"]
        website <- map["website"]
    }
}
