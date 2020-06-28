//
//  ApplicationConstant.swift
// SampleFeeds
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

/// Dimensions for view position and size

struct Dimensions {
  /// X Position of any view
  static let loaderXPosition = 100
  /// Y Position of any view
  static let loaderYPosition = 200
  /// Width of any view
  static let loaderWidth = 40
  /// Height of any view
  static let loadderHeight = 40
}

/// Common Messages Strings

enum Message: String {
  /// Specific title for message
  case sampleTask
  /// Network unavailable message
  case networkNotReachable
  /// Title for message
  case header
  /// Returing string value for each case
  var value: String {
    switch self {
    case .sampleTask:
      return "Albums"
    case .networkNotReachable:
      return "Network Not Available, Please check your connection."
    case .header:
      return "Alert"
    }
  }
}

/// TableView Cell Identifiers
struct CellIdentifiers {
  /// Landing page cell identifier
  static let tableViewCell = "TableViewCell"
}

/// Common colors instances
struct ApplicationColor {
  /// White color from UIColor
  static let whiteColor = UIColor.white
  /// Black color from UIColor
  static let blackColor = UIColor.black
}

/// Formatting Type
enum FormateType: String {
  case json
  case xml
}

/// Methode For Accesing
enum MethodeAccess: String {
  case album = "album.search"
}
/**
 Receiving the RGB seprate color value as CGFloat Type then convert and return UiColor instance
 - Parameters:
 - red:Red as CGFloat
 - green :Green as CGFloat
 - blue :Blue as CgFloat
 - Returns: UIColor instace from RGB values
 */

func generateColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
  return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}
