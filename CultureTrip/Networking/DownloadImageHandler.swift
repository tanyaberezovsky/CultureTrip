//
//  DownloadImageHandler.swift
//  cultureTrip
//
//  Created by Tanya Berezovsky on 30/09/2020.
//  Copyright © 2020 Tanya Berezovsky. All rights reserved.
//

import UIKit

protocol DownloadImageHandler {
    func processRequest(_ data: Data, url: String)
}

func downloadImage( _ urlStr: String, _ handler: DownloadImageHandler)
{
    
    guard let url: URL = URL(string: urlStr) else {
        return
    }
    let session = URLSession.shared
    
    let request = URLRequest(url: url)
    
    
    let task = session.dataTask(with: request, completionHandler: {
        (
        _data, response, error) in
        
        if let data = _data
        {
            handler.processRequest(data, url: urlStr)
        }
        
    })
    
    task.resume()
    
}

class RequestHandler: NSObject, DownloadImageHandler {
    
    private var image:UIImageView? = nil
    private var imageCache: NSCache<AnyObject, AnyObject>
    
    init(_ image: UIImageView, imageCache: NSCache<AnyObject, AnyObject>)
    {
        self.imageCache = imageCache
        self.image = image
        // self.images
    }
    
    func processRequest(_ data: Data, url: String)
    {
        let image_data = UIImage(data: data)
        imageCache.setObject(image_data!, forKey: url as AnyObject)
        
        DispatchQueue.main.async(execute: {
            self.image?.image = image_data
            self.image?.alpha = 0.0

            UIView.animate(withDuration: 0.2, animations: {
                self.image?.alpha = 1.0
            })
        })
    }
}
