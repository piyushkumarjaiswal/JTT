//
//  ApplicationExtension.swift
// SampleFeeds
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

/// Image cache container for image caching
let imageCache = NSCache<AnyObject, AnyObject>()

/// ImageView Extension
extension UIImageView {
  /**
   Loading imade on imageView from either from url or cache
   - Parameters: Url string for image loading
   */
  func setImage(from urlString: String) {
    image = UIImage(named: "placeholder")
    if let url = NSURL(string: urlString) {
      if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
        image = imageFromCache as? UIImage
        return
      }
      DispatchQueue.global(qos: .default).async {
        if let data = NSData(contentsOf: url as URL) {
          DispatchQueue.main.async {
            if let image = UIImage(data: data as Data) {
              self.image = image
              imageCache.setObject(image, forKey: url as AnyObject)
            }
          }
        }
      }
    }
  }
}

/// Tableview Extensions
extension UITableView {
  /**
   Identifying weather the given index path is last visible indexpath
   - Parameters:
       - indexPath: Indexpath for cell
   - Returns: Boolean value for last indexpath detection
   
   */
  func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
    guard let lastIndexPath = indexPathsForVisibleRows?.last else {
      return false
    }
    return lastIndexPath == indexPath
  }
}

/// UIViewController Extension

extension UIViewController {
  /**
   Showing alert inside the application using UIAlertController
   - Parameters:
      - message: Message inside alert
      - title: Title in header of alert
   */
  func showAlert(message: String?, title: String = Message.header.value) {
    let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}


extension UIView {
  /// Making Border Color
  @IBInspectable var borderColor: UIColor? {
    set {
      layer.borderColor = newValue!.cgColor
    }
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      } else {
        return nil
      }
    }
  }
  /// Making Border Width
  @IBInspectable var borderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
  
  /* BORDER RADIUS */
  /// Making Border Radius
  @IBInspectable var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
      clipsToBounds = newValue > 0
    }
    get {
      return layer.cornerRadius
    }
  }
  func bounceAnimation(duration: TimeInterval = 1.0,
                       delay: TimeInterval = 0.0,
                       damping: CGFloat = 0.2,
                       velocity: CGFloat = 8.0,
                       minimumScale: CGFloat = 0.1,
                       completion: ((Bool) -> Void)? = nil) {
    transform = CGAffineTransform(scaleX: minimumScale, y: minimumScale)
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping,
                   initialSpringVelocity: velocity, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                    self.transform = CGAffineTransform.identity
    }, completion: { finished in
      completion?(finished)
    })
  }

}


/// UILabel Extension
extension UILabel {
/// Making Underline to UILabel
func underline() {
  let underLineColor: UIColor = .blue
  let underLineStyle = NSUnderlineStyle.single.rawValue
  let labelAtributes:[NSAttributedString.Key : Any]  = [
    
    NSAttributedString.Key.foregroundColor: UIColor.blue,
    NSAttributedString.Key.underlineStyle: underLineStyle,
           NSAttributedString.Key.underlineColor: underLineColor
       ]
  let underlineAttributedString = NSAttributedString(string: text ?? "",
                                                          attributes: labelAtributes)
       attributedText = underlineAttributedString
   }
}
