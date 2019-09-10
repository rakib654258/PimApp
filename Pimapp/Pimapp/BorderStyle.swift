//
//  BorderStyle.swift
//  Pimapp
//
//  Created by Rakib Hasan Shayan on 29/7/19.
//  Copyright © 2019 Rakib Hasan Shayan. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BorderStyle: UIView {
    @IBInspectable var cornerRadius: Double{
        get {
            return Double(self.layer.cornerRadius)
        }set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.black{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor = UIColor.black{
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0{
        didSet{
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
}
