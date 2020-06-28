//
//  User.swift
//  Jet2TravelTask
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//


import Foundation
import CoreData

/// Feed Result from Api
struct FeedResult: Codable {
  let id, createdAt, content: String?
  let comments, likes: Int?
  let media: [Media]?
  let user: [User]?
}
/// User Model For CoreData And Parsing Inside the Feed
public class User: NSObject, NSCoding, Codable {
  var about : String?
  var avatar : String?
  var blogId : String?
  var city : String?
  var createdAt : String?
  var designation : String?
  var id : String?
  var lastname : String?
  var name : String?
  
  public required init?(coder: NSCoder) {
    about = coder.decodeObject(forKey: "about") as? String
    avatar = coder.decodeObject(forKey: "avatar") as? String
    blogId = coder.decodeObject(forKey: "blogId") as? String
    name = coder.decodeObject(forKey: "name") as? String
    city = coder.decodeObject(forKey: "city") as? String
    createdAt = coder.decodeObject(forKey: "createdAt") as? String
    designation = coder.decodeObject(forKey: "designation") as? String
    id = coder.decodeObject(forKey: "id") as? String
    lastname = coder.decodeObject(forKey: "lastname") as? String
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(about, forKey: "about")
    aCoder.encode(avatar, forKey: "avatar")
    aCoder.encode(blogId, forKey: "blogId")
    aCoder.encode(city, forKey: "city")
    aCoder.encode(createdAt, forKey: "createdAt")
    aCoder.encode(designation, forKey: "designation")
    aCoder.encode(id, forKey: "id")
    aCoder.encode(lastname, forKey: "lastname")
    aCoder.encode(name, forKey: "name")
  }
}
