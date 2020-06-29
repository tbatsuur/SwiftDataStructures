//
//  SwiftExtensions.swift
//  tbatsuur
//
//  Created by tbatsuur on 2018-04-02.
//  Copyright © 2018 tbatsuur. All rights reserved.
//

import UIKit

extension NSObject {
    var address: UnsafeMutableRawPointer {
        get {
            return Unmanaged<AnyObject>.passUnretained(self as AnyObject).toOpaque()
        }
    }
}

//MARK: INT
extension Int {
    var address: UnsafeMutableRawPointer {
        get {
            return Unmanaged<AnyObject>.passUnretained(self as AnyObject).toOpaque()
        }
    }
    var isEven: Bool {
        if self % 2 == 0 {
            return true
        }else {
            return false
        }
    }
    var getAllFactors: [Int]? {
        if self > 0 {
            // n must be integer and positive
            var arrayFactors = [Int]()
            
            if self == 1 {
                arrayFactors.append(1)
                //END
            }else {
                arrayFactors.append(1)
                if self.isEven {
                    if self > 2 {
                        arrayFactors.append(2)
                        if self > 4 {
                            //Check under n/2
                            let intPossibleHighestFactor = Int(self/2)
                            for possibleFactor in 3...intPossibleHighestFactor {
                                if possibleFactor.isFactorOf(self) {
                                    arrayFactors.append(possibleFactor)
                                }
                            }
                        }
                    }
                }else {
                    if self > 6 {
                        //Check under n/2 rounded, just to speed it up
                        let doublePossibleHighestFactor = self/2
                        let intPossibleHighestFactor = Int(doublePossibleHighestFactor)
                        for possibleFactor in 3...intPossibleHighestFactor {
                            if possibleFactor.isFactorOf(self) {
                                arrayFactors.append(possibleFactor)
                            }
                        }
                    }
                }
                //LAST FACTOR
                arrayFactors.append(self)
                //END
            }
            print(arrayFactors.count)
            return arrayFactors
        }else {
            return nil
        }
    }
    func isFactorOf(_ bigNumber: Int)-> Bool {
        if bigNumber % self == 0 {
            return true
        }else {
            return false
        }
    }
    var factorial: Int {
        var output = 1
        if self > 1 {
            for x in 1...self {
                output *= x
            }
        }
        return output
        //        var n = self
        //        var result = 1
        //        while n > 1 {
        //            result *= n
        //            n -= 1
        //        }
        //        return result
    }
    var toBinary: String {
        return String(self, radix: 2)
    }
    var toHexadecimal: String {
        return String(self, radix: 16)
    }
}

//MARK: DOUBLE
extension Double {
    var address: UnsafeMutableRawPointer {
        get {
            return Unmanaged<AnyObject>.passUnretained(self as AnyObject).toOpaque()
        }
    }
    mutating func roundTo(_ decimalPoint: Int) {
        let num: Double = Double(pow(10.0, Double(decimalPoint)))
        let y = Double(Darwin.round(num * self)/num)
        self = y
    }
    func returnRoundedTo(_ decimalPoint: Int)-> Double {
        let num: Double = Double(pow(10.0, Double(decimalPoint)))
        let y = Double(Darwin.round(num * self)/num)
        return y
    }
}

//MARK: STRING
extension String {
    var address: UnsafeMutableRawPointer {
        get {
            return Unmanaged<AnyObject>.passUnretained(self as AnyObject).toOpaque()
        }
    }
    var binaryToDecimal: Int {
        return Int(self, radix: 2)!
    }
    var hexadecimalToDecimal: Int {
        return Int(self, radix: 16)!
    }
    var binaryToHexadecimal: String {
        return String(self.binaryToDecimal, radix: 16)
    }
    var hexadecimalToBinary: String {
        return String(self.hexadecimalToDecimal, radix: 2)
    }
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    var isNumeric: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }
    var isEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isPhoneNumber: Bool {
        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    var isStrongPass: Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
        let passTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        
        return passTest.evaluate(with: self)
    }
    func convertToDate()-> Date {
        var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dateString = self
        
        if dateString == "0000-00-00 00:00:00" {
            dateString = "1900-01-01 00:00:00"
            date = formatter.date(from: dateString)!
        }else {
            date = formatter.date(from: dateString)!
        }
        
        return date
    }
    func convertToDateCurrentTimeZone()-> Date {
        var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.calendar = NSCalendar.current
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        var dateString = self
        
        if dateString == "0000-00-00 00:00:00" {
            dateString = "1900-01-01 00:00:00"
            date = formatter.date(from: dateString)!
        }else {
            print(dateString)
            date = formatter.date(from: dateString)!
            print(date)
            
        }
        return date
    }
    func localToUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "MDT")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
    
    func convertTo10DigitPhone()-> String?{
        if self.count == 15 {
            var indexOfText = self.index(self.startIndex, offsetBy: 3)
            let substring1 = self[indexOfText...]
            
            indexOfText = self.index(self.endIndex, offsetBy: -9)
            var first3Digits = substring1[..<indexOfText]
            
            indexOfText = self.index(substring1.endIndex, offsetBy: -4)
            let last4Digits = substring1[indexOfText..<substring1.endIndex]
            
            indexOfText = self.index(substring1.startIndex, offsetBy: 4)
            let secondIndex = self.index(substring1.endIndex, offsetBy: -5)
            let second3Digits = substring1[indexOfText..<secondIndex]
            
            first3Digits.append(contentsOf: second3Digits)
            first3Digits.append(contentsOf: last4Digits)
            let editedPhone: String = String(first3Digits)
            return editedPhone
        }else {
            return nil
        }
    }
    
    func heightForText(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}






//MARK: DATE
extension Date {
    var address: UnsafeMutableRawPointer {
        get {
            return Unmanaged<AnyObject>.passUnretained(self as AnyObject).toOpaque()
        }
    }
    var isToday: Bool {
        let dateToday = Date()
        if dateToday.getDay() == self.getDay() && dateToday.getMonth() == self.getMonth() && self.getYear() == dateToday.getYear() {
            return true
        }else {
            return false
        }
    }
    var isFuture: Bool {
        let interval = self.timeIntervalSinceNow
        if interval > 0 {
            return true
        }else {
            return false
        }
    }
    
    //MARK: DATE HELPER FUNCTIONS
    func getYear()-> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return year
    }
    func getMonth()-> Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        return month
    }
    func getDay()-> Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        return day
    }
    func getWeekday() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return weekday
    }
    func getStringWeekday() -> String {
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: self)
        
        if day == 2 {
            return "Monday"
        }else if day == 3 {
            return "Tuesday"
        }else if day == 4 {
            return "Wednesday"
        }else if day == 5{
            return "Thursday"
        }else if day == 6 {
            return "Friday"
        }else if day == 7 {
            return "Saturday"
        }else if day == 1 {
            return "Sunday"
        }else {
            return ""
        }
    }
    func getStringMonth() -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        if month == 1 {
            return "January"
        }else if month == 2 {
            return "February"
        }else if month == 3 {
            return "March"
        }else if month == 4 {
            return "April"
        }else if month == 5 {
            return "May"
        }else if month == 6 {
            return "June"
        }else if month == 7 {
            return "July"
        }else if month == 8 {
            return "August"
        }else if month == 9 {
            return "September"
        }else if month == 10 {
            return "October"
        }else if month == 11 {
            return "November"
        }else if month == 12 {
            return "December"
        }else {
            return ""
        }
    }
    
    //TIME
    func getHour()-> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        return hour
    }
    func getMinute()-> Int {
        let calendar = Calendar.current
        let min = calendar.component(.minute, from: self)
        return min
    }
    
}

