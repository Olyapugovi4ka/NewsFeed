//
//  WebImageView.swift
//  NewsFeed
//
//  Created by MacBook on 04.04.2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            self.image = nil
            return }
        self.currentUrlString = imageUrl
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            //print("from cache")
            return
        }
        
       // print("from internet")
        let dataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data =  data, let response = response {
                    self?.handleLoadedImage(data: data, response: response)
                    
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse){
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}