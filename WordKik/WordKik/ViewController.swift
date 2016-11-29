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

class ViewController: UIViewController, SegueHandler {

    
    var datasource:[BandViewModel] = []
    var bandDetail:BandDetails?
    
    @IBOutlet var tableview: UITableView!
    var cell:BandCell? = nil
    
    enum SegueIdentifier: String {
        case DetailViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        self.tableview.rowHeight = 30
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segueIdentifierForSegue(segue) {
            
        case .DetailViewController:
            let detail = segue.destination as? DetailViewController
            detail?.inject(self.bandDetail!)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let c:BandAPI = BandAPI()
        c.downloadDetails(id: indexPath.row + 1, completion: { (result) in
            print(result)
            let details = Mapper<BandDetails>().map(JSON: result as! [String : Any])
            self.bandDetail = details
            self.performSegueWithIdentifier(.DetailViewController, sender: self)
        })
    }
    
}

extension ViewController {
    
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

//    private func presentDetails(index:NSIndexPath) {
//        let sb = UIStoryboard(name: self.storyboardName(), bundle: Bundle(identifier: DetailViewController.identifier))
//        let vc = sb.instantiateViewControllerWithIdentifier(DetailViewController.identifier) as! DetailViewController
//        //vc.model = photoViewModels[index.row]
//        self.navigationController?.pushViewController(vc, animated: true)
//    }


