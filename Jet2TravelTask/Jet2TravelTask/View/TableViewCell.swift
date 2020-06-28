//
//  HomeTableViewCell.swift
// Jet2TravelTask
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

/// Tableview Cell class

class TableViewCell: UITableViewCell {
  
  /// Label User Name
  @IBOutlet private weak var labelUserName: UILabel!
  /// Label Designation
  @IBOutlet private weak var labelDesignation: UILabel!
  /// ImageView for Artical Post
  @IBOutlet private weak var imageViewArticle: ImageLoader!
  /// ImageView for Artical Profile
  @IBOutlet private weak var imageViewProfile: ImageLoader!
  /// Label Article Title
  @IBOutlet private weak var labelAtricleTitle: UILabel!
  /// Label Article url
  @IBOutlet private weak var labelArticleUrl: UILabel!
  /// Label Article Content
  @IBOutlet private weak var labelAtricleContent: UILabel!
  /// Label Likes
  @IBOutlet private weak var labelLikes: UILabel!
  /// Label Comments
  @IBOutlet private weak var labelComments: UILabel!
  /// Label Date Time
  @IBOutlet private weak var labelTime: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    labelArticleUrl.underline()
  }
  /**
   Setting Up Cell Detail With Row
   - Parameters:
   - detail: Detail for cell item
   - index:        Cell Index
   */
  func setUpCell(detail: Feed, index: Int) {
    
    let user  = detail.user?.first
    let media = detail.media?.first
    
    if let urlString = user?.avatar, let url = URL(string: urlString){
      imageViewProfile.loadImageWithUrl(url)
      imageViewProfile.isHidden = false
      
    }else {
      imageViewProfile.isHidden = true
    }
    labelUserName.text = user?.name
    labelDesignation.text = user?.designation
    if let urlString = media?.image, let url = URL(string: urlString){
      imageViewArticle.loadImageWithUrl(url)
    }
    
    if let content = detail.content {
      labelAtricleContent.text = content
      labelAtricleContent.isHidden = false
    }else {
      labelAtricleContent.isHidden = true
    }
    
    if let title = media?.title {
      labelAtricleTitle.text = title
      labelAtricleTitle.isHidden = false
    }else {
      labelAtricleTitle.isHidden = true
    }
    
    if let url  = media?.url {
      labelArticleUrl.text = url
      labelArticleUrl.isHidden = false
    }else {
      labelArticleUrl.isHidden = true
    }
    
    labelLikes.text = "\(Double(detail.likes/1000))K LIKES"
    labelComments.text = "\(Double(detail.comments/1000))K Comments"
    
    if let createdAt = detail.createdAt {
      let date = convertDateFormater(createdAt)
      labelTime.text = date
    }else {
      labelTime.text = ""
    }
  }
  
  /// Presenting imageViewer with initializing the imagepickercontroller
  func setUpImageViewer(image: UIImage? = nil) {
    
    if let viewController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController, let imageObj = imageViewArticle.image {
      let imageInfo   = ImageInfo(image: imageObj, imageMode: .aspectFit)
      let transitionInfo = TransitionInfo(fromView: imageViewArticle)
      let imageViewer = ImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
      imageViewer.dismissCompletion = {}
      viewController.present(imageViewer, animated: true, completion: nil)
    }
  }
}

