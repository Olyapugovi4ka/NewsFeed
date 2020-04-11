//
//  UserResponse.swift
//  NewsFeed
//
//  Created by MacBook on 08.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

struct UserResponseWrapped: Decodable {
    let response:[UserResponse]
}

struct UserResponse: Decodable {
    let photo100:String?
}
