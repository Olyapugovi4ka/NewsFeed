//
//  NewsFeedInteractor.swift
//  NewsFeed
//
//  Created by MacBook on 03.04.2020.
//  Copyright (c) 2020 MacBook. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    switch request {
       
    case .getNewsFeed:
        service?.getFeed(completion: {[weak self] (revealedPostIds, feed) in
            self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
        })
    case .revealPostIds(postId: let postId):
        service?.revealedPostId(forPostId: postId, completion: { (revealedPostId, feed) in
            self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostId))
        })
    case .getUser:
        service?.getUser(completion: {[weak self] (userResponse) in
            self?.presenter?.presentData(response: .presentUserInfo(user: userResponse))
        })
    case .getNextBatch:
        
        self.presenter?.presentData(response: .presentFooterLoader)
        service?.getNextBanch(completion: { (revealedPostId, feed) in
            self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostId))
        })
    }
    
  }
   
   
  
}
