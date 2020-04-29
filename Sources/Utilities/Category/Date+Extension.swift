//
//  Date+Extension.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import Foundation
/// Date Format type
enum DateFormatType: String {
    /// Time
    case time = "HH:mm:ss"

    /// Date with hours
    case dateWithTime = "yyyy-MM-dd HH:mm:ss"

    /// Date
    case date = "dd-MMM-yyyy"
     case dateShort = "dd-MM-yyyy"
    
    case dateWithTime3Z = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dateWithTimeOr3Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    case dateWithTime1Z = "yyyy-MM-dd'T'HH:mm:ss.SZ"
    
    case showDateWithTimeZ = "yyyy-MM-dd HH:mm:ss.Z"
    
    case dateWithTimeShow = "yyyy-MM-dd hh:mm a"
    
    case localDateWithTime = "dd-MMM-yyyy'T'HH:mm:ss.SSSZ" //
    
    case localDateWithTimeShowA = "dd-MM-yyyy hh:mm a"
    
    case localDateWithTimeShow = "dd-MMM-yyyy hh:mm a"
    
    
}

extension NSObject {
    class var className: String {
        return String(describing: self.self)
    }
}


extension NSObject {

    var defaultDate: String {
        return "1900-01-01T00:00:00.000"
    }

    func convertToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatType.date.rawValue
        let serverDate: Date = dateFormatter.date(from: dateString)!
        return serverDate
    }


       func convertToDate(dateString: String, dateformat formatType: DateFormatType) -> Date {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat =  formatType.rawValue
        var serverDate = dateFormatter.date(from: dateString)
        if serverDate == nil {
             dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
            serverDate = dateFormatter.date(from: dateString)
        }
           return serverDate!
       }
    
    func convertToString(date: Date, dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue

        let newDate: String = dateFormatter.string(from: date)
        print(newDate)

        return newDate
    }

    func convertToSeconds(timeString: String, dateFormat type: DateFormatType) -> Int {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue

        let date: Date = dateFormatter.date(from: timeString)!
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        let hour = comp.hour
        let minute = comp.minute
        // let sec = comp.second

        let totalSeconds = ((hour! * 60) * 60) + (minute! * 60) //+ sec!

        return totalSeconds
    }


    /// To Show the Date in String format
    func convertToShowFormatDate(dateString: String, dateFormat from: DateFormatType, dateFormat to: DateFormatType) -> String {

        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = from.rawValue
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)!

        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = to.rawValue
        let newDate: String = dateFormatterString.string(from: serverDate)
        print(newDate)

        return newDate
    }
    
    func convertToShowFormatDate(dateString: String) -> String {

        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let serverDate: Date = dateFormatterDate.date(from: dateString)!

        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "yyyy-MM-dd hh:mm a"
        let newDate: String = dateFormatterString.string(from: serverDate)
        print(newDate)

        return newDate
    }
    
      func convertToShowFormatDateLocal(dateString: String) -> String {

          let dateFormatterDate = DateFormatter()
          dateFormatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
          
          let serverDate: Date = dateFormatterDate.date(from: dateString)!

          let dateFormatterString = DateFormatter()
          dateFormatterString.dateFormat = "dd-MMM-yyyy hh:mm a"
          let newDate: String = dateFormatterString.string(from: serverDate)
          print(newDate)

          return newDate
      }
    
    func showFormatDate(_ dateString: String, dateFormat from: DateFormatType, dateFormat to: DateFormatType) -> String {

        var dateString = dateString
          var find = dateString.first { $0 == "." }
        
          if find == nil {
              dateString = "\(dateString).000"
          }
          find = dateString.first { $0 == "+" }
          if (find != nil) {
              dateString = dateString.replacingOccurrences(of: "+07:00", with: "")
          }
         
          let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = from.rawValue
          
          let serverDate: Date = dateFormatterDate.date(from: dateString)!

          let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = to.rawValue
          let newDate: String = dateFormatterString.string(from: serverDate)

          return newDate

    }
    
    func showLocal( _ dateString: String) -> String {
    
        var dateString = dateString
        var find = dateString.first { $0 == "." }
      
        if find == nil {
            dateString = "\(dateString).000"
        }
        find = dateString.first { $0 == "+" }
        if (find != nil) {
            dateString = dateString.replacingOccurrences(of: "+07:00", with: "")
            dateString = dateString.replacingOccurrences(of: "+0700", with: "")
        }
       
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let serverDate = dateFormatterDate.date(from: dateString)!

        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = "dd-MM-yyyy hh:mm a"
        let newDate: String = dateFormatterString.string(from: serverDate)

        return newDate
    }

}

// Date extension
extension Date {
  static func getStringFromDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    let dateString = dateFormatter.string(from: date)
    return dateString
  }
    
  static func getDateFromString(dateString: String) -> Date? {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime,
                               .withDashSeparatorInDate,
                               .withFullDate,
                               .withColonSeparatorInTimeZone]
    guard let date = formatter.date(from: dateString) else {
      return nil
    }
    return date
  }
  // get an ISO timestamp
  static func getISOTimestamp() -> String {
    let isoDateFormatter = ISO8601DateFormatter()
    let timestamp = isoDateFormatter.string(from: Date())
    return timestamp
  }
}

extension String {
  public func formatISODateString(dateFormat: String) -> String {
    var formatDate = self
    let isoDateFormatter = ISO8601DateFormatter()
    if let date = isoDateFormatter.date(from: self) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = dateFormat
      formatDate = dateFormatter.string(from: date)
    }
    return formatDate
  }
  
  public func date() -> Date {
    var date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    if let isoDate = isoDateFormatter.date(from: self) {
      date = isoDate
    }
    return date
  }
}

