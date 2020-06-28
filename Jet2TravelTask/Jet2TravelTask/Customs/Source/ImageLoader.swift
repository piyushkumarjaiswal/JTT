//
//  ImageLoader.swift
//  Jet2TravelTask
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import Foundation


import UIKit

/// Subclassing Imageview for loading
class ImageLoader: UIImageView {
  /// ImageView Url
  var imageURL: URL?
  
  /// activity indicator
  let activityIndicator = UIActivityIndicatorView()
  
  /// Loading image with Url
  func loadImageWithUrl(_ url: URL) {
    
    // setup activityIndicator...
    activityIndicator.color = .darkGray
    
    addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    imageURL = url
    
    image = nil
    activityIndicator.startAnimating()
    
    // retrieves image if already available in cache
    if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
      
      self.image = imageFromCache
      activityIndicator.stopAnimating()
      return
    }
    
    // image does not available in cache.. so retrieving it from url...
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      
      if error != nil {
        print(error as Any)
        DispatchQueue.main.async(execute: {
          self.activityIndicator.stopAnimating()
        })
        return
      }
      
      DispatchQueue.main.async(execute: {
        
        if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
          
          if self.imageURL == url {
            self.image = imageToCache
          }
          
          imageCache.setObject(imageToCache, forKey: url as AnyObject)
        }
        self.activityIndicator.stopAnimating()
      })
    }).resume()
  }
}
