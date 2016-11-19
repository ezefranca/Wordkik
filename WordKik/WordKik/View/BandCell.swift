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
                }
            }
        }
    
    
    @IBOutlet private var name: UILabel!
    
    func setup(viewModel: BandViewModel){
        self.viewModel = viewModel
        self.setupView()
    }
    
    func setupView() {
        self.contentView.superview?.backgroundColor = UIColor.black
        //self.accessoryView?.backgroundColor = UIColor.black
    }
}
