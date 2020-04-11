//
//  NewsFeedPresenter.swift
//  NewsFeed
//
//  Created by MacBook on 03.04.2020.
//  Copyright (c) 2020 MacBook. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
  weak var viewController: NewsFeedDisplayLogic?
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter:DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "d MMM 'в' HH:mm"
        return df
    }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    switch response {
    
    
    case .presentNewsFeed(let feed, let revealPostIds):
        
        print(revealPostIds)
        
        let cells = feed.items.map { (feedItem) in
            cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealPostIds)
        }
        let footerTitle = String.localizedStringWithFormat(NSLocalizedString("newsfeed cells count", comment: ""), cells.count)
        let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
        viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        
    case .presentUserInfo(user: let user):
        let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
        viewController?.displayData(viewModel: .displayUser(userViewModel: userViewModel))
    case .presentFooterLoader:
        viewController?.displayData(viewModel: .displayFooterLoader)
    }
  }
  
    private func cellViewModel (from feedItem: FeedItem, profiles:[Profile], groups: [Group], revealedPostIds: [Int]) -> FeedViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSize = revealedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        //let attachment = self.photoAttachment(feedItem: feedItem)
        let attachments = self.photoAttachments(feedItem: feedItem)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: attachments, isFullSizePost: isFullSize)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        return FeedViewModel.Cell.init(postId: feedItem.postId, iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formattedCounter(feedItem.likes?.count),
                                       comments: formattedCounter(feedItem.comments?.count),
                                       shares: formattedCounter(feedItem.reposts?.count),
                                       views: formattedCounter(feedItem.views?.count),
                                       photoAttachments: attachments, sizes: sizes)
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    
    private func profile(for sourceId: Int, profiles:[Profile], groups:[Group]) -> ProfileRepresentable {
        let profilesOgGroups:[ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOgGroups.first { myProfileRepresentable -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.scrBig,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height)
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments  = feedItem.attachments else { return [] }
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment?  in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.scrBig,
                                                              width: photo.width,
                                                              height: photo.height)
        }
    }
}
