//
//  HomeViewModel.swift
//  Jet2TravelTask
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/// View Model for HomeViewController Screen
class ViewModel: NSObject {
  /// Country detail object receive from API
  private(set) public var feeds: [Feed]? = []
  /// Network manger for API call
  private var manager: NetworkManager?
  /// For Paging Request
  private(set) public var currentPage:Int {
    set {
      UserDefaults.standard.set(newValue, forKey: "page")
    }
    get {
      return ((UserDefaults.standard.value(forKey: "page") as? Int) ?? 0)
    }
  }
  /// Overrding Initailization function
  override init() {
    super.init()
    manager = NetworkManager()
    retrieveData()
  }
  /// Viewmodel binding handler
  var viewModelBinding :((_ status: [Feed]?, _ error: String?) -> Void) = { _, _  in  }

  /**
  Getting Post details from API and responding to viewmodel handler
  - Precondition: Checking Network Connection
  */
  func getPostFromApi(index:Int = 0) {
    if Reachability.isConnectedToNetwork() == false {
      viewModelBinding(nil, Message.networkNotReachable.value)
      return
    }
    currentPage  = (index == 0) ? currentPage : index
    let param = ["page":"\(currentPage)","limit":"10"]
    manager?.fetchPost(detail: param, completion: {[weak self] (response, message) in
      guard let getSelf = self else { return }
      if response != nil {
        if (response?.count ?? 0) > 0 {
          getSelf.currentPage += 1
        }
        DispatchQueue.main.async {
          getSelf.saveResult(data: response)
        }
      } else {
        getSelf.viewModelBinding(nil, message)
      }
    })
  }
  /**
   Saving  details from API and responding to viewmodel handler
  - Parameter:  Feed List
  */
  private func saveResult(data:[FeedResult]?) {
    guard let list = data else { return }
    let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
    for item in list {
      let userEntity = NSEntityDescription.entity(forEntityName: "Feed", in: managedContext)!
      if let object = NSManagedObject(entity: userEntity, insertInto: managedContext) as? Feed {
        object.id = item.id
        object.comments = Int32(item.comments ?? 0)
        object.content = item.content
        object.createdAt = item.createdAt
        object.media = item.media
        object.user = item.user
        object.likes = Int32(item.likes ?? 0)
        CoreDataStack.sharedInstance.saveContext()
     }
    }
    retrieveData()
  }
  /**
   Retriving List from CoreData
  */
   private func retrieveData() {
      //We need to create a context from this container
    let result = CoreDataStack.sharedInstance.fetchCodeDataResult()
    feeds?.removeAll()
    feeds?.append(contentsOf: result ?? [])
    viewModelBinding(feeds, nil)
  }
}
