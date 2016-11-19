//
//  BandViewModel.swift
//  WordKik
//
//  Created by Ezequiel on 18/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import Foundation

struct BandViewModel {
    
    var name: String?
    var id: String?
    
    var band: Band! {
        didSet{
            if let model = band {
            self.name = model.name
            self.id = model.identifier
        }
        }
    }
    
    init(band: Band) {
        setBand(band: band)
    }
    
    mutating func setBand(band:Band) {
        self.band = band
    }
    
}
