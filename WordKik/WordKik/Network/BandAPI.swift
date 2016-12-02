//
//  BandAPI.swift
//  WordKik
//
//  Created by Ezequiel on 20/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import Alamofire

struct BandAPI {
    
    let detailsUrl = "https://powerful-oasis-33182.herokuapp.com/bands/"
    
    func downloadDetails(id:Int, completion: @escaping (Any) -> Void) {
        Alamofire.request(detailsUrl+"\(id)").responseJSON { response in
            if let JSON = response.result.value {
                completion(JSON)
            }
        }
    }
    

}
