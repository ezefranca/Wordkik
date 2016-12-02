//
//  CountriesViewController.swift
//  WordKik
//
//  Created by Ezequiel on 30/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import MRLCircleChart

struct Data {
    static let maxValue: Double = 1
    static var values: [Double] = []
}

class CountriesViewController: UIViewController, SegueHandler {

    //MARK: - Instance Variables
    
    var dataSource:MRLCircleChart.NumberChartDataSource?
    var datasource:[BandDetailsViewModel] = []
    var countries:[String] = []
    typealias T = [BandDetailsViewModel]
    
    enum SegueIdentifier: String {
        case ListViewController
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet var chart: MRLCircleChart.Chart!
    @IBOutlet var bandName: UILabel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        self.title = "Bands per Country"
        getCountries()
        countCountries()
    }
    
    //MARK: - Setup
    
    fileprivate func setupChart() {
        chart.selectHandler = { index in
            self.bandName.isHidden = false
            self.bandName.text = String(self.countries[index]  + "  " +  String(Data.values[index] * 100) + "%")
        }
        chart.deselectHandler = { index in
            self.bandName.isHidden = true
        }
    }
    
    //MARK: -  Actions
    
    fileprivate func run () {
        func runAfter(_ time: Double, block: @escaping () -> ()) {
            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                block()
            })
        }
        
        runAfter(0.1) {
            self.chart.reloadData()
        }
    }
    
    func getCountries() {
        for band in datasource {
            guard let country = band.country else { return }
            countries.append(country)
        }
    }
    
    func countCountries() {
        var counted:[String: Double] = [:]
        
        for c in countries {
            counted[c] = (counted[c] ?? 0) + (1.0/Double(countries.count))
        }
        countries.removeAll()
        for c in counted.keys {
            print(c)
            countries.append(c)
            Data.values.append(counted[c]!)
        }
        
        let d = MRLCircleChart.NumberChartDataSource(items: Data.values, maxValue: Data.maxValue)
        chart.dataSource = d
        self.dataSource = d
        setupChart()
        run ()
        print(counted)
    }
}

extension CountriesViewController {
    func inject(_ thing: T) {
        self.datasource = thing
    }
    
    func assertDependencies() {
        assert(!datasource.isEmpty)
    }
}
