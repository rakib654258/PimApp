//
//  PopUpImageVC.swift
//  Pimapp
//
//  Created by Rakib Hasan Shayan on 1/8/19.
//  Copyright © 2019 Rakib Hasan Shayan. All rights reserved.
//

import UIKit

class PopUpImageVC: UIViewController {

    @IBOutlet weak var imgLbl: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
