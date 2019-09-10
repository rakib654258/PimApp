//
//  loginJsonModel.swift
//  Pimapp
//
//  Created by Rakib Hasan Shayan on 26/7/19.
//  Copyright © 2019 Rakib Hasan Shayan. All rights reserved.
//

import Foundation

struct LoginInfo: Decodable {
    let status_code: String
    let message: String
    let user_data: User_data_info
}

struct User_data_info: Decodable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
}
