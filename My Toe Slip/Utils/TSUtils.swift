//
//  TSUtils.swift
//  My Toe Slip
//
//  Created by swordEdge on 10/16/15.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreGraphics

extension UIImage {
    func imageWithColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

class TSUtils {
    
    /******* Just Get Color ********/
    static func getGMAquaColor() -> UIColor {
        return UIColor (red: 16/256.0, green: 185/256.0, blue: 215/256.0, alpha: 1)
    }
    
    /******* Just Get Fonts *******/
    static func getAppFont(_ fontsize: CGFloat) -> UIFont! {
        return UIFont(name: "ProximaNovaSoft-Regular", size: fontsize);
    }
    
    static func getAppMediumFont(_ fontsize: CGFloat) -> UIFont! {
        return UIFont(name: "ProximaNovaSoft-Medium", size: fontsize);
    }
    
    static func getAppBoldFont(_ fontsize: CGFloat) -> UIFont! {
        return UIFont(name: "ProximaNovaSoft-Bold", size: fontsize);
    }
    
    static func getAppSemiBoldFont(_ fontsize: CGFloat) -> UIFont! {
        return UIFont(name: "ProximaNovaSoft-SemiBold", size: fontsize);
    }
    /*
    Define UIColor from hex value
    
    @param rgbValue - hex color value
    @param alpha - transparency level
    */
    static func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    static func parseDateTime(_ dateStr: String!, format:String="yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> Date! {
        if(dateStr == nil || dateStr.isEmpty) {
            return nil;
        }
        let dateFmt = DateFormatter()
        dateFmt.timeZone = NSTimeZone.default
        dateFmt.dateFormat = format
        return (dateFmt.date(from: dateStr)! as NSDate!) as Date!
    }
    
    static func printDateTime(date: NSDate!,format:String="yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> String! {
        if(date == nil) {
            return "";
        }
        let dateFmt = DateFormatter()
        dateFmt.timeZone = NSTimeZone.default
        dateFmt.dateFormat = format
        return dateFmt.string(from: date as Date);
    }
    
    static func distanceFromCoordinate(fromLat: Double, fromLon: Double, toLat: Double, toLon: Double) -> Double {
        let locA = CLLocation(latitude: fromLat, longitude: fromLon);
        let locB = CLLocation(latitude: toLat, longitude: toLon);
        
        return locA.distance(from: locB);
    }
    
    static func setTextAccessoryView(text: UIView, target: AnyObject?, selector: Selector?) {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: text, action: #selector(UIResponder.resignFirstResponder))
        barButton.tintColor = UIColor.black
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolbar.barTintColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue:241.0/255.0, alpha:1.0)
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: text, action: #selector(UIResponder.resignFirstResponder))
        
        toolbar.items = [flexible, flexible, barButton]
        
        if let ctrl = text as? UITextView {
            ctrl.inputAccessoryView = toolbar
        }
        else if let ctrl = text as? UITextField {
            ctrl.inputAccessoryView = toolbar
        }
        
    }
    
    static func stringFromTimeInterval(interval:TimeInterval) -> NSString {
        
        let ti = NSInteger(interval)
        
        let ms = Int((ti % 1) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
    
    /*
        1 : Attribute Name
        2 : StartIndex
        3 : Length
        4 : Value
    */
    
    static func insertStyle2Label(label : UILabel , params : [(String, Int, Int, AnyObject)]){
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: label.text!)
        
        for (attributeName, startIndex, length, value) : (String, Int, Int, AnyObject) in params {
            if attributeName == "font"{
                attributedString.addAttribute(NSFontAttributeName, value: value, range: NSMakeRange(startIndex, length))
            }else if attributeName == "color" {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: value, range: NSMakeRange(startIndex, length))
            }
        }
        
        label.attributedText = attributedString
    }
    
    static func widthOfScreen() -> CGFloat{
        let screenRect = UIScreen.main.bounds
        return screenRect.size.width
    }
    
    static func heightOfScreen() -> CGFloat {
        let screenRect = UIScreen.main.bounds
        return screenRect.size.height
    }

    static func heightOfNonSearchBarHeader() -> CGFloat {
        return heightOfScreen()
    }
    
    static func heightOfHeader() -> CGFloat {
        return heightOfScreen() * 0.16042
    }
    
}


extension Date {
    // yyyy-MM-dd hh:mm a
    static func date2String(date : Date, datePattern : String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = datePattern
        let strDate = dateFormatter.string(from: date as Date)
        return strDate
    }
    
    static func string2Date(strDate : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: strDate)
        return date! as Date
    }
    
    static func intervalString2Date(strIntervalDate : String) -> Date {
        
        let timeinterval : TimeInterval = (strIntervalDate as NSString).doubleValue
        let date = Date(timeIntervalSince1970:timeinterval)
        return date
    }
    
    static func strDate2stringHumanReadableDate(strDate : String, datePattern : String = "EEEE MMM dd") -> String{
        let date = Date.string2Date(strDate: strDate)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = datePattern
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }

    static func date2StringHumanReadableDate(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM. dd yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
