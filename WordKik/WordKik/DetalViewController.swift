//
//  DetalViewController.swift
//  WordKik
//
//  Created by Ezequiel on 20/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    @IBOutlet private var imageDetails: UIImageView!
    @IBOutlet private var albumID: UILabel!
    @IBOutlet private var imageID: UILabel!
    @IBOutlet private var imageTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //DetailViewController
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
