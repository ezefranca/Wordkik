//
//  BandCell.swift
//  WordKik
//
//  Created by Ezequiel on 18/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit

class BandCell: UITableViewCell {
    static let reuseIdentifier: String = "photocell"
    
    private var viewModel: BandViewModel!{
        
        didSet{
                if let vm = viewModel {
                    self.name.text = vm.name
                    self.id.text = vm.id
                }
            }
        }
    
    
    @IBOutlet private var name: UILabel!
    @IBOutlet private var id: UILabel!
    
    func setup(viewModel: BandViewModel){
        self.viewModel = viewModel
    }
}
