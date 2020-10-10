//
//  ImageCacheLoader.swift
//  CultureTrip
//
//  Created by Tanya Berezovsky on 08/10/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit
//typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class ImageCacheLoader {
    private var session: URLSession
    private var cache: NSCache<NSString, UIImage>
    private var runningRequests: [String: URLSessionDownloadTask]
    
    init() {
        session = URLSession.shared
        self.cache = NSCache()
        runningRequests = [String: URLSessionDownloadTask]()
    }
    
    func getImageCache(imagePath: String) -> UIImage? {
        guard let image = self.cache.object(forKey: imagePath as NSString) else {
              return nil
        }
        return image
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping ((UIImage) -> ())) {
        
        if let image = self.cache.object(forKey: imagePath as NSString) {
                completionHandler(image)
        }
        
        guard let url = URL(string: imagePath) else {
            completionHandler(UIImage())
            return
        }

        let task = session.downloadTask(with: url, completionHandler: { [weak self] (data, respones, error) in
               
            defer {self?.runningRequests.removeValue(forKey: imagePath) }

            if error != nil {
               print(error ?? "")
               return
            }
            if let data = try? Data(contentsOf: url) {
              guard let imageToCache = UIImage(data: data) else { return  completionHandler(UIImage()) }
              self?.cache.setObject(imageToCache, forKey: imagePath as NSString)
              DispatchQueue.main.async {
                  completionHandler(imageToCache)
              }
            }
        })
        task.resume()
        runningRequests[imagePath] = task
    }
    
    func cancelLoad(_ imagePath: String) {
      runningRequests[imagePath]?.cancel()
      runningRequests.removeValue(forKey: imagePath)
    }
}

