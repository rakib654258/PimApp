//
//  HomeVC.swift
//  Pimapp
//
//  Created by Rakib Hasan Shayan on 24/7/19.
//  Copyright © 2019 Rakib Hasan Shayan. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var dateSelectLbl: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var brandInfo: BrandsInfo?
    var companyName: [String] = []
    var didSelectCell = 0
//    var pagination: [Int] = Array()
//    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var index = 0
//        while index < limit{
//            pagination.append(index)
//            index += 1
//        }
        fetchJSON()
        // Do any additional setup after loading the view.
    }
    func fetchJSON(){
        let jsonUrl = "https://whatef.com/api/fg-top-brands"
        guard let url = URL(string: jsonUrl) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil, response != nil else{
                print("Something is wrong!")
                return
            }
            do{
                let myData = try JSONDecoder().decode(BrandsInfo.self, from: data)
                self.brandInfo = myData
                print("Downloaded")
                for i in 0..<myData.top_brands.count{
                    self.companyName.append(myData.top_brands[i].companyName)
                    //print(myData.top_brands.count)
                }
                
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                }
            }catch let error{
                print("Error is \(error)")
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyName.count
        //return pagination.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TopBrandsTableViewCell
        cell.brandNameLbl.text = brandInfo?.top_brands[indexPath.row].companyName
        if let orderAmount = brandInfo?.top_brands[indexPath.row].orderAmount {
            cell.profitLbl.text = "$\(orderAmount)"
        }else{
            print("Order amount is nil")
        }
        
        return cell
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == pagination.count - 1{
//            //we are at least cell load more content
//            if pagination.count < companyName.count{
//                //we need to bring more records as there are some pending records available
//                var index = pagination.count
//                limit = index + 10
//                while index < limit{
//                    pagination.append(index)
//                    index += 1
//                }
//                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
//            }
//        }
//    }
//    @objc func loadTable(){
//        self.tableViewOutlet.reloadData()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCell = indexPath.row
        performSegue(withIdentifier: "itemViewSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendData = segue.destination as! ItemsVC
        sendData.items = (brandInfo?.top_brands[didSelectCell].items)!
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
