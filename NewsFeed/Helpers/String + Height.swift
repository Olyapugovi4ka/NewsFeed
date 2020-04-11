//
//  String + Height.swift
//  NewsFeed
//
//  Created by MacBook on 05.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit


extension String {
    func height(width:CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
