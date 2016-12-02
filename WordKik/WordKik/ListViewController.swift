//
//  ViewController.swift
//  WordKik
//
//  Created by Ezequiel on 15/11/16.
//  Copyright © 2016 Ezequiel França @ezefranca. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SVProgressHUD

class ListViewController: UIViewController, SegueHandler {

     //MARK: - Instance Variables
    
    var datasource:[BandViewModel] = []
    fileprivate var details:BandDetailsViewModel?
    fileprivate var detailsCountries:[BandDetailsViewModel] = []
    var bandDetail:BandDetails?
    
    enum SegueIdentifier: String {
        case DetailViewController
        case CountriesViewController
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet var tableview: UITableView!
    var cell:BandCell? = nil
    

     //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     //MARK: - Actions
    
    @IBAction func showCountriesController(_ sender: UIBarButtonItem) {
        for i in 1..<21 {
            download(id: i, finish: {(finish) in
                let model = BandDetailsViewModel(band: finish)
                self.detailsCountries.append(model)
                if i == 20 {
                    self.hideLoader()
                    self.performSegueWithIdentifier(.CountriesViewController, sender: self)
                }
            })
        }
        //self.performSegueWithIdentifier(.CountriesViewController, sender: self)
    }
    
    fileprivate func download(id: Int, finish: @escaping (BandDetails) -> Void) {
        self.showLoader()
        let c:BandAPI = BandAPI()
        c.downloadDetails(id: id, completion: { (result) in
            guard let details = Mapper<BandDetails>().map(JSON: result as! [String : Any]) else { return }
            finish(details)
        })
    }
    
    func downloadAndShowDetails(id:Int) {
        download(id: id, finish: {(finish) in
            self.bandDetail = finish
            self.hideLoader()
            self.performSegueWithIdentifier(.DetailViewController, sender: self)
        })
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segueIdentifierForSegue(segue) {
            
        case .DetailViewController:
            let detail = segue.destination as? DetailViewController
            guard let details = self.bandDetail else { return }
            let banddetails = BandDetailsViewModel(band: details)
            detail?.inject(banddetails)
        
        
        case .CountriesViewController:
            let countries = segue.destination as? CountriesViewController
            countries?.inject(self.detailsCountries)
        }
        
    }


}


extension ListViewController : UITableViewDataSource{
    
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


extension ListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)!
        cell.backgroundColor = UIColor.clear
        tableView.deselectRow(at: indexPath, animated: true)
        downloadAndShowDetails(id: indexPath.row + 1)
    }

}

extension ListViewController {
    
    func loadJson() {
        
        let jsonText = try! String(contentsOfFile:(Bundle.main.path(forResource: "bands", ofType: "json"))!)
        var dict:NSDictionary?
        
        if let data = jsonText.data(using: String.Encoding.utf8) {
            
            do {
                dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                
                if let bandsDict = dict
                {
                    let bands = Mapper<Bands>().map(JSON: bandsDict as! [String : Any])
                    for band in (bands?.bands)! {
                    let b = BandViewModel(band: band)
                    datasource.append(b)
                }
                tableview.reloadData()
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    
    func showLoader() {
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }

}
