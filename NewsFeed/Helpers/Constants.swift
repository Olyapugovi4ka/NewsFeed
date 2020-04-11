//
//  Constants.swift
//  NewsFeed
//
//  Created by MacBook on 06.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight:CGFloat = 36.0
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottowViewHeight:CGFloat = 44.0
    
    static let bottomViewViewHeight: CGFloat = 44.0
    static let bottomViewViewWidth: CGFloat = 80.0
    
    static let bottomViewViewsIconSize: CGFloat = 24.0
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButonSize = CGSize(width: 170.0, height: 30.0)
    
}
