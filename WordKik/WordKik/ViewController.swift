//
//  ViewController.swift
//  WordKik
//
//  Created by Ezequiel on 15/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {

    
    var datasource:[BandViewModel] = []
    
    @IBOutlet var tableview: UITableView!
    var cell:BandCell? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJson() {
        if let path = Bundle.main.path(forResource: "bands", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    
                     let bands = Mapper<Bands>().map(JSON: jsonResult as! [String : Any])
                    
                    for band in (bands?.bands)! {
                        let b = BandViewModel(band: band)
                        datasource.append(b)
                    }
                    
                    tableview.reloadData()
                } catch {}
            } catch {}
        }
    }


}


extension ViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datasource.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCell(withIdentifier: "BandCell") as? BandCell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! BandCell
        cell.setup(viewModel: (datasource[indexPath.row]))
        
    }
}


extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


