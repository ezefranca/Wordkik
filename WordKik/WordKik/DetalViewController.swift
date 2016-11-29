//
//  DetalViewController.swift
//  WordKik
//
//  Created by Ezequiel on 20/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import PINRemoteImage

protocol Injectable {
    associatedtype T
    func inject(_ thing: T)
    func assertDependencies()
}

class DetailViewController: UIViewController, Injectable {
    
    static let identifier = "DetailViewController"
    typealias T = BandDetails
    
    var bandDetails:BandDetails?
    
    @IBOutlet private var bandImage: UIImageView!
    @IBOutlet private var bandName: UILabel!
    @IBOutlet private var bandCountry: UILabel!
    @IBOutlet private var bandGenre: UILabel!
    @IBOutlet var flagImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bandName.text = bandDetails?.name
        bandImage.pin_updateWithProgress = true
        flagImageView.pin_updateWithProgress = true
        bandImage.pin_setImage(from: URL(string: (bandDetails?.image)!))
        flagImageView.pin_setImage(from: URL(string: (bandDetails?.country_flag)!))
        //flagImageView.image = UIImage(named: (Locale.autoupdatingCurrent.localizedString(forIdentifier: "USA") )!)
        //DetailViewController
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func openBandWebsite(_ sender: Any) {
    }
}

extension DetailViewController {
    func inject(_ thing: T) {
        self.bandDetails = thing
    }
    
    func assertDependencies() {
        assert(bandDetails != nil)
    }
}
