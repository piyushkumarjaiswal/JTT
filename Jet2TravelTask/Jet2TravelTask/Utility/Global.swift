//
//  Global.swift
//  SampleFeeds
//
//  Created by Piyush on 28/06/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import Foundation

/// Getting Past Duration by comparing Dates
 func getTime(_ date:Date,currentDate:Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    let now = currentDate
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())

    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else {
        return "Just now"
    }

}


struct ObjectCache {
    static let currencyRateFormatter: NumberFormatter = {
        var numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.alwaysShowsDecimalSeparator = false
        return numberFormatter
    }()
}


private var cachedFormatters = [String : DateFormatter]()

extension DateFormatter {

  static func cached(withFormat format: String) -> DateFormatter {
    if let cachedFormatter = cachedFormatters[format] { return cachedFormatter }
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    cachedFormatters[format] = formatter
    return formatter
  }

}
/// Converting Date Formate for Specific Date
func convertDateFormater(_ dateString: String) -> String {
  let dateFormatter = DateFormatter.cached(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
  let date = dateFormatter.date(from: dateString)
  
  let newDateFormatter = DateFormatter.cached(withFormat: "yyyy-MM-dd HH:mm:ss")
  let timeStamp = newDateFormatter.string(from: date!)
  guard let convertedDate = newDateFormatter.date(from: timeStamp) else { return ""}
  let time  = getTime(convertedDate, currentDate: Date(), numericDates: true)
  return time
}
