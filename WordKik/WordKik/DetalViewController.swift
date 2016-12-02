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
    
     //MARK: - Instance Variables
    
    static let identifier = "DetailViewController"
    typealias T = BandDetailsViewModel
    var bandDetails:BandDetailsViewModel?
    
     //MARK: - IBOutlets
    
    @IBOutlet private var bandImage: UIImageView!
    @IBOutlet private var bandName: UILabel!
    @IBOutlet private var bandCountry: UILabel!
    @IBOutlet private var bandGenre: UILabel!
    @IBOutlet var flagImageView: UIImageView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        self.title = bandDetails?.name
        initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    
    func initialSetup() {
        self.bandName.text = bandDetails?.name
        bandImage.pin_updateWithProgress = true
        flagImageView.pin_updateWithProgress = true
        bandImage.pin_setImage(from: URL(string:(bandDetails?.image)!))
        flagImageView.pin_setImage(from: URL(string: (bandDetails?.country_flag)!))
    }
    
    //MARK: - Actions
    
    @IBAction func openBandWebsite(_ sender: Any) {
        if let url = URL(string: "http://" + (bandDetails?.website)!) {
        UIApplication.shared.open(url, options: [:])
        }
    }
}

//MARK: - Extensions

extension DetailViewController {
    func inject(_ thing: T) {
        self.bandDetails = thing
    }
    
    func assertDependencies() {
        assert(bandDetails != nil)
    }
}
