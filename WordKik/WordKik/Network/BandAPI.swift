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
    
    func downloadDetails(id:Int, completion: @escaping (Any) -> Void) {
        
        Alamofire.request("https://powerful-oasis-33182.herokuapp.com/bands/\(id)").responseJSON { response in
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                completion(JSON)
            }
        }
    }
    

}
