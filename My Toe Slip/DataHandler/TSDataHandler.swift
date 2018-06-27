//
//  TSDataHandler.swift
//  ToeSlip
//
//  Created by a on 12/16/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSDataHandler: NSObject {
    static let sharedInstance = TSDataHandler()
    static var contracts : [TSContract]?
    static var trucks : [TSTruck]?
    static var prices : [TSPrice]?
    static var storages : [TSStorage]?
    
    static func getContracts(callback: @escaping (([TSContract]?) ->())) {
        guard self.contracts == nil else {
            callback(self.contracts)
            return
        }
        
        TSAPIHandler.sharedInstance.getContracts(token: TSCacheHandler.sharedInstance.getSavedToken()!) { (success, info) in
            if (success) {
                self.contracts = info as? [TSContract]
            }
            
            callback(self.contracts)
        }
    }
    
    static func getTrucks(callback: @escaping (([TSTruck]?) ->())) {
        guard self.trucks == nil else {
            callback(self.trucks)
            return
        }
        
        TSAPIHandler.sharedInstance.getTrucks(token: TSCacheHandler.sharedInstance.getSavedToken()!) { (success, info) in
            if (success) {
                self.trucks = info as? [TSTruck]
            }
            
            callback(self.trucks)
        }
    }
    
    static func getPrices(callback: @escaping (([TSPrice]?) ->())) {
        guard self.prices == nil else {
            callback(self.prices)
            return
        }
        
        TSAPIHandler.sharedInstance.getPrices(token: TSCacheHandler.sharedInstance.getSavedToken()!) { (success, info) in
            if (success) {
                self.prices = info as? [TSPrice]
            }
            
            callback(self.prices)
        }
    }
    
    static func getStorages(callback: @escaping (([TSStorage]?) ->())) {
        guard self.storages == nil else {
            callback(self.storages)
            return
        }
        
        TSAPIHandler.sharedInstance.getStorages(token: TSCacheHandler.sharedInstance.getSavedToken()!) { (success, info) in
            if (success) {
                self.storages = info as? [TSStorage]
            }
            
            callback(self.storages)
        }
    }
}
