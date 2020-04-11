//
//  API.swift
//  NewsFeed
//
//  Created by MacBook on 02.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.103"
    
    static let newsFeed = "/method/newsfeed.get"
    static let paramsForNewsFeed = ["filters": "post, photo"]
    
    static let user = "/method/users.get"
    
}
