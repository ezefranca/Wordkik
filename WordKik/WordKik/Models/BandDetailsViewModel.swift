//
//  BandDetailsViewModel.swift
//  WordKik
//
//  Created by Ezequiel on 30/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import Foundation

struct BandDetailsViewModel {
    
    public var name: String?
    public var genre: String?
    public var image: String?
    public var country: String?
    public var country_flag: String?
    public var website: String?
    
    
    var band: BandDetails! {
        didSet{
            if let model = band {
                self.name = model.name
                self.genre = model.genre
                self.image = model.image
                self.country = model.country
                self.country_flag = model.country_flag
                self.website = model.website

            }
        }
    }
    
    init(band: BandDetails) {
        setBand(band: band)
    }
    
    mutating func setBand(band:BandDetails) {
        self.band = band
    }
    
}
