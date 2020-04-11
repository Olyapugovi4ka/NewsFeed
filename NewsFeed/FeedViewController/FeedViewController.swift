//
//  FeedViewController.swift
//  NewsFeed
//
//  Created by MacBook on 02.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit


class FeedViewController: UIViewController {
    
    private var fetcher:DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
   //     fetcher.getFeed { (feedResponse) in
         //   guard let feedResponse = feedResponse else { return }
//            feedResponse.items.map { (feedItem) in
//                print(feedItem.date)
//            }
        //}
    }
}
