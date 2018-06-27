//
//  TSCacheHandler.swift
//  ToeSlip
//
//  Created by a on 12/11/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSCacheHandler: NSObject {
    static let sharedInstance = TSCacheHandler()
    
    func setApplicationLaunched(launched: Bool) {
        let userDefault = UserDefaults.standard
        userDefault.set(launched, forKey: "beenOnBoarding")
        userDefault.synchronize()
    }
    
    func getApplicationLaunchedBefore() -> Bool {
        return UserDefaults.standard.bool(forKey: "beenOnBoarding")
    }
    
    ///// Token
    func getSavedToken() -> String? {
        guard let token : String = UserDefaults.standard.string(forKey: "auth_token") else {
            return nil
        }
        
        return token
    }
    
    func resetToken() {
        let userDefault = UserDefaults.standard
        userDefault.set(nil, forKey: "auth_token")
        userDefault.synchronize()
    }
    
    func saveToken(token: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(token, forKey: "auth_token")
        userDefault.synchronize()
    }
    
    
    ///// Me info
    func resetMeInfo() {
        let userDefault = UserDefaults.standard
        userDefault.set(nil, forKey: "me")
        userDefault.synchronize()
    }
    
    func saveMeInfo(me: TSUser) {
        let userDefault = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: me)
        userDefault.set(encodedData, forKey: "me")
        userDefault.synchronize()
    }
    
    func getSavedMeInfo() -> TSUser?{
        let userDefault = UserDefaults.standard
        guard let decoded  = userDefault.object(forKey: "me") as? Data else {
            return nil
        }
        
        return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? TSUser
    }
}
