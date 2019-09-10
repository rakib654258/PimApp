//
//  ItemsVC.swift
//  Pimapp
//
//  Created by Rakib Hasan Shayan on 30/7/19.
//  Copyright © 2019 Rakib Hasan Shayan. All rights reserved.
//

import UIKit

class ItemsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    var items : [Items] = Array()
    var itemImageIndex = 0

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //For collectionView margin padding
        let layout = collectionViewOutlet.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 8, left: 9, bottom: 2, right: 9)
        //layout.minimumInteritemSpacing = 5
        //layout.itemSize = CGSize(width: (self.collectionViewOutlet.frame.size.width - 20)/2, height: (self.collectionViewOutlet.frame.size.height)/2)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! ItemsCollectionViewCell
        if let imageURL = URL(string: items[indexPath.row].image){
            DispatchQueue.main.async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    cell.imgOutlet.image = image
                }
            }
        }
        cell.productNameOutlet.text = items[indexPath.row].productName
        cell.priceOutlet.text = "$\(items[indexPath.row].price)"
        cell.piecesOutlet.text = items[indexPath.row].count
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemImageIndex = indexPath.row
        performSegue(withIdentifier: "itemImageSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendData = segue.destination as! PopUpImageVC
        if let imageURL = URL(string: items[itemImageIndex].image){
            DispatchQueue.main.async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    sendData.imgLbl.image = image
                }
            }
        }
        //sendData.imgLbl.image = itemImage
    }
    
}
