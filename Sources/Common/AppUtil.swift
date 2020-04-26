//
//  AppUtil.swift
//  Yeeld
//
//  Created by admin on 11/15/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import UIKit

final class AppUtil: NSObject {
    
    class var appDelegate: AppDelegate? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate
    }
    
    class var visibleViewController: UIViewController? {
        if let keyWindow = UIWindow.key, let rootVC = keyWindow.rootViewController {
            return AppUtil.getVisibleViewController(from: rootVC)
        }
        return nil
        
    }
    
    class func getVisibleViewController(from vc: UIViewController) -> UIViewController {
        if vc is UINavigationController {
            return AppUtil.getVisibleViewController(from: ((vc as? UINavigationController)?.visibleViewController)!)
        } else if vc is UITabBarController {
            return AppUtil.getVisibleViewController(from: ((vc as? UITabBarController)?.selectedViewController)!)
        } else {
            if vc.presentedViewController != nil {
                return AppUtil.getVisibleViewController(from: vc.presentedViewController!)
            } else {
                return vc
            }
        }
    }
    
    class func setObjectToDictionary(dict: AnyObject, key: String, object: Any) {
        if !(object is NSNull) {
            dict.setValue(object, forKey: key)
        }
    }

    class func checkStringIsEmpty(_ stringNeedCheck: String) -> Bool {
        //debugPrint("string need check is " + stringNeedCheck)
        if (stringNeedCheck.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count ) == 0 {
            return true
        }
        return false
    }
    
    class func formatStringWithFrenchCurrency(amountStr: Double) -> String {
        
        var result = String.init(format: "%.2f", amountStr)
        result = result.replacingOccurrences(of: ".", with: ",")
        return result
    }
    
    class func isNull(someObject: AnyObject?) -> Bool {
        guard let someObject = someObject else {
            return true
        }
        
        return (someObject is NSNull)
    }
    
    class func checkNullValues(_ value: AnyObject) -> Bool {
        
        if (value as AnyObject).isEqual(NSNull()) && (value as AnyObject).isEqual(NSNull()) {
            return true
        }
        if "\(value)" == "<null>" {
            return true
        }
        if "\(value)" == "(null)" {
            return true
        }
        if "\(value)".count == 0 {
            return true
        }
        return false
    }
    
    class func removeWhiteSpacingInString(_ stringNeedRemove: String) -> String {
        let stringRemoved = stringNeedRemove.trimmingCharacters(in: .whitespaces)
        return stringRemoved
    }
    
    class func validateEmail(_ emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,4}"
//        let emailRegEx = "^[_A-Za-z0-9-+]+(.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,4})$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: emailString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) == false {
            return false
        }
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if emailString.prefix(1).rangeOfCharacter(from: characterset.inverted) != nil {
            return false
        }
        
        return true
    }
    
    class func showAlertWithMessage(_ mesage: String) {
        
        if AppUtil.checkStringIsEmpty(mesage) {
            return
        }
        if AppUtil.visibleViewController is UIAlertController {
            return
        }
        let alert = UIAlertController.init(title: kMessageTitle, message: mesage, preferredStyle: .alert)
        
        let cancel = UIAlertAction.init(title: kClose, style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        
        visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    class func showAlert(_ mesage: String, callback: @escaping () -> (Void)) {
        
        if AppUtil.checkStringIsEmpty(mesage) {
            return
        }
        if AppUtil.visibleViewController is UIAlertController {
            return
        }
        let alert = UIAlertController.init(title: kMessageTitle, message: mesage, preferredStyle: .alert)
        
        let cancel = UIAlertAction.init(title: kClose, style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            callback()
        }
        
        alert.addAction(cancel)
        
        visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    class func validatePassword(_ password: String) -> Bool {

//        let tempString = CharacterSet.
        let charactersetLowercase = CharacterSet.lowercaseLetters//(charactersIn: "abcdefghijklmnopqrstuvwxyz")
        let charactersetUppercase = CharacterSet.uppercaseLetters//(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let charactersetNumber = CharacterSet(charactersIn: "0123456789")
        let charactersetSpecial = CharacterSet(charactersIn: "~!@#$%^&*_-+=`|\\(){}[]:;\"\'<>,.?/")
        
        if password.rangeOfCharacter(from: charactersetLowercase) == nil {
            
            return false
        }
        
        if password.rangeOfCharacter(from: charactersetUppercase) == nil {
            return false
        }
        
        if password.rangeOfCharacter(from: charactersetNumber) == nil {
            return false
        }
        
        if password.rangeOfCharacter(from: charactersetSpecial) == nil {
            return false
        }
        
        if password.contains(" ") {
            return false
        }
        
        return true
    }
    
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    class func makeMediaUrl(_ value: String?) -> URL {
        if let value = value {
            if value.contains("http") || value.contains("https") {
                return URL(string: value)!
            }
            return URL(string: "\(kBaseServerDev)/\(value)")!
        }
        return URL(string: kBaseServerDev)!
    }

    // MARK: Add Atribute and get Size text
    class func attributeSpacingCharacterTextView(_ textView: UITextView, andSpacing spacing: Float, andFont font: UIFont) {
        if AppUtil.checkStringIsEmpty(textView.text) {
            return
        }
        let attributedString = NSMutableAttributedString(string: textView.text)
        attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: (textView.text.count )))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: (textView.text.count )))
        attributedString.addAttribute(.foregroundColor, value: textView.textColor ?? UIColor.clear, range: NSRange(location: 0, length: (textView.text.count )))
        textView.attributedText = attributedString
    }
    
    class func attributeSpacingCharacterString(_ label: UILabel, andSpacing spacing: Float) {
        if AppUtil.checkStringIsEmpty(label.text!) {
            return
        }
        if label.text != "" {
            let attributedString = NSMutableAttributedString(string: label.text ?? "")
            attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: (label.text?.count ?? 0)))
            label.attributedText = attributedString
        }
    }
    
    class func attributeSpacing(forButtonCharacterString button: UIButton, andSpacing spacing: Float, for state: UIControl.State) {
        if AppUtil.checkStringIsEmpty(button.currentTitle!) {
            return
        }
        let attributedString = NSMutableAttributedString(string: button.currentTitle ?? "")
        attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: (button.currentTitle?.count ?? 0)))
        attributedString.addAttribute(.foregroundColor, value: button.currentTitleColor, range: NSRange(location: 0, length: (button.currentTitle?.count ?? 0)))
        button.setAttributedTitle(attributedString, for: state)
    }
    
    class func attributeSpacing(forTextFieldCharacterString textField: UITextField, andSpacing spacing: Float) {
        if AppUtil.checkStringIsEmpty(textField.text!) {
            return
        }
        let attributedString = NSMutableAttributedString(string: textField.text ?? "")
        attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: (textField.text?.count ?? 0)))
        textField.attributedText = attributedString
    }

    class func convertTimeStampToStringDate(timeStamp: String?, formartString: String) -> String {
        if let timeStamp = timeStamp {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = formartString
            let oDate = Date(timeIntervalSince1970: TimeInterval(timeStamp)!)
            return dateFormat.string(from: oDate)
        }
        return ""
    }
    
    class func convertTimeStampToDateStringBySymbol(timeStamp: String?, formartString: String) -> String {
        if let timeStamp = timeStamp {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = formartString
            dateFormat.amSymbol = "AM"
            dateFormat.pmSymbol = "PM"
            let oDate = Date(timeIntervalSince1970: TimeInterval(timeStamp)!)
            return dateFormat.string(from: oDate)
        }
        return ""
    }
    
    class func convertDateformatBySymbol(date: Date, formatString: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = formatString
        dateFormat.amSymbol = "AM"
        dateFormat.pmSymbol = "PM"
        return dateFormat.string(from: date)
    }
    
    class func convertTimeStampToDate(timeStamp: String) -> Date {
        let oDate = Date(timeIntervalSince1970: TimeInterval(timeStamp)!)
        return oDate
    }
    
    class func convertDateToStringDate(date: Date, formatString: String) -> String {
        let dateFormat = DateFormatter()
//        dateFormat.locale
        dateFormat.dateFormat = formatString
        return dateFormat.string(from: date)
    }
    
    class func convertDateToTimeStamp(date: Date) -> Double {
        return date.timeIntervalSince1970
    }

    class func reconvertDateString(_ dateStr: String, fromFormatString: String, toFormatString: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = fromFormatString
        guard let date = dateFormat.date(from: dateStr) else {
            return ""
        }
        dateFormat.dateFormat = toFormatString
        return dateFormat.string(from: date)
    }
    
    class func reformartDate(_ dateStr: String, format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormat.date(from: dateStr) else {
            return "N/a"
        }
        dateFormat.dateFormat = format
        return dateFormat.string(from: date)
    }
    
    class func printCountBtnTwoDates(mStartDate: Date, mEndDate: Date) -> Int {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        var newDate = mStartDate
        var daysListArray = [String]()
        daysListArray.removeAll()
        
        while newDate <= mEndDate {
            formatter.dateFormat = "yyyy-MM-dd"
            daysListArray.append(formatter.string(from: newDate))
            newDate = calendar.date(byAdding: .day, value: 1, to: newDate)!
        }
        // print("daysListArray: \(daysListArray)") // if you want to print list between start date and end date
        return daysListArray.count
    }

   

    class func caculateYear(dob: String?) -> Int {
        let curYear = Int(AppUtil.convertDateToStringDate(date: Date(), formatString: "yyyy")) ?? 0
        let dobYear = Int(dob?.components(separatedBy: "-").first ?? "0") ?? 0
        return curYear - dobYear
    }
    
    class func convertStringDateToDate(timeStamp: String) -> Date {
        let dateformater = DateFormatter.init()
        dateformater.dateFormat = "MMM d ',' E  "
        let date = dateformater.date(from: timeStamp)
        return date!
    }

    class func formatNumberToString(number: NSNumber) -> String {
        let numberformat = NumberFormatter()
        numberformat.groupingSeparator = ","
        numberformat.groupingSize = 3
        numberformat.numberStyle = .decimal
        return numberformat.string(from: number)!
    }

    class func formatNumber(_ number: String?) -> String? {
        guard let number = number, let dNumber = Double(number) else {
            return nil
        }
        let numberformat = NumberFormatter()
        numberformat.groupingSeparator = ","
        numberformat.groupingSize = 3
        numberformat.numberStyle = .decimal
        return numberformat.string(from: NSNumber.init(value: dNumber))
    }

    class func getTimeAgo(_ time: Double) -> String? {
        
        let SECOND_MILLIS: Double = 1000
        let MINUTE_MILLIS: Double = 60 * SECOND_MILLIS
        let HOUR_MILLIS: Double = 60 * MINUTE_MILLIS
        let DAY_MILLIS: Double = 24 * HOUR_MILLIS
        let YEAR_MILLIS: Double = 365 * DAY_MILLIS
        var time: Double = time
        if time < 1000000000000 {
            // if timestamp given in seconds, convert to millis
            time *= 1000
        }
        
        let now = Date().timeIntervalSince1970 * 1000
        if time > now || time <= 0 {
            return nil
        }
        
        let diff = now - time
        if diff < MINUTE_MILLIS {
            let str = String(format: "%ds", Int(diff/SECOND_MILLIS))
            return str
        } else if diff < HOUR_MILLIS {
            let str = String(format: "%dm", Int(diff/MINUTE_MILLIS))
            return str
        } else if diff < DAY_MILLIS {
            let str = String(format: "%dh", Int(diff/HOUR_MILLIS))
            return str
        } else if diff < YEAR_MILLIS {
            let str = String(format: "%dd", Int(diff/DAY_MILLIS))
            return str
        } else {
            let str = String(format: "%dy", Int(diff/YEAR_MILLIS))
            return str
        }
    }
    
    class func validInputTextFiledNumber(text: String) -> Bool {
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: text)
        let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return alphabet
    }
    
    class func validInputTextFiledPercent(text: String) -> Bool {
        let allowedCharacters = "1234567890."
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: text)
        let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return alphabet
    }
}
