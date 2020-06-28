//
//  Media.swift
//  Jet2TravelTask
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import Foundation
import CoreData

/// Media Model For Core Data And Parsing
public class Media: NSObject,NSCoding ,Codable {
  var image: String?
  var designation: String?
  var blogId : String?
  var createdAt : String?
  var id : String?
  var title : String?
  var url : String?
  
  public required init?(coder: NSCoder) {
    image = coder.decodeObject(forKey: "image") as? String
    designation = coder.decodeObject(forKey: "designation") as? String
    blogId = coder.decodeObject(forKey: "blogId") as? String
    createdAt = coder.decodeObject(forKey: "createdAt") as? String
    id = coder.decodeObject(forKey: "id") as? String
    title = coder.decodeObject(forKey: "title") as? String
    url = coder.decodeObject(forKey: "url") as? String
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(image, forKey: "image")
    aCoder.encode(designation, forKey: "designation")
    aCoder.encode(blogId, forKey: "blogId")
    aCoder.encode(createdAt, forKey: "createdAt")
    aCoder.encode(id, forKey: "id")
    aCoder.encode(title, forKey: "title")
    aCoder.encode(url, forKey: "url")
  }
}
