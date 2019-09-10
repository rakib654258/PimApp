//
//  BrandsJsonModel.swift
//  Pimapp
//
//  Created by Rakib Hasan Shayan on 29/7/19.
//  Copyright © 2019 Rakib Hasan Shayan. All rights reserved.
//

import Foundation

struct BrandsInfo: Decodable {
    let status_code: String
    let chart_data: [Chart_Data]
    let top_brands: [Top_Brands]
}

struct Chart_Data: Decodable {
    let companyName: String
    //let order_amount: Any
}

struct Top_Brands: Decodable {
    let companyName: String
    let orderAmount: Double
    let items: [Items]
}

struct Items: Decodable {
    let dates: String
    let productName: String
    let companyName: String
    let price: String
    let image: String
    let activated_at: String
    //let available_on: nil
    let order_amount: String
    let count: String
}
