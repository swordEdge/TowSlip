//
//  TSAPIHandler.swift
//  ToeSlip
//
//  Created by swordEdge on 11/16/16.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

// All of server/client communication functions are defined in this class
// Alamofire which is swift port of AFNetworking which is proven and widely used in Objective C
// is used


import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class TSAPIHandler {
    static let sharedInstance = TSAPIHandler()
    
    let TSAPIURL: String = "http://api.apartmentpermits.com/api/" //TODO: Need to be changed.
    let HEADER: HTTPHeaders = ["Content-Type": "application/json"]
    
    /// Login : [TESTED]
    func login(_ username: String, password: String, callback: @escaping ((Bool, String?) ->())) {
        
        Alamofire.request(TSAPIURL + "auth/login",
                          method: .post,
                          parameters: [ "username": username, "password": password ],
                          encoding: JSONEncoding.default,
                          headers: HEADER)
        .responseJSON { (response) in
            switch(response.result){
            case .success(let info):
                let sJSONObj = JSON(info)
                guard let success = sJSONObj["success"].bool, success else {
                    callback(false, sJSONObj["error_code"].string)
                    return
                }
                
                callback(success, sJSONObj["data"]["token"].string)
                debugPrint(response)
                break
            case .failure(let error):
                callback(false, (error as Error).localizedDescription)
                break
            }
        }
    }
    
    /// Get Me(for SideBar)
    func getMe(token: String, callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "auth/me",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let user = Mapper<TSUser>().map(JSONString: sJSONObj["data"].rawString()!)
                    callback(success, user as AnyObject)
                    debugPrint(response)
                    break
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }

    /// Get Tows(for History Screen)
    func getTows(token: String, callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "tows",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let tows = Mapper<TSTow>().mapArray(JSONString: sJSONObj["data"]["tow"].rawString()!)
                    callback(success, tows as AnyObject)
                    debugPrint(response)
                    break
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }
    
    //// Post new Tow
    func postTow(token: String, towData: [String: Any], callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "tows",
                          method: .post,
                          parameters: towData,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token,
                                    "Content-Type": "application/json"])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let tows = Mapper<TSTow>().mapArray(JSONString: sJSONObj["data"]["tow"].rawString()!)
                    callback(success, tows as AnyObject)
                    debugPrint(response)
                    break
                    
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }
    
    //// Get Contracts(for VehicleList Screen)
    func getContracts(token: String, callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "contracts",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let contracts = Mapper<TSContract>().mapArray(JSONString: sJSONObj["data"]["contracts"].rawString()!)
                    callback(success, contracts as AnyObject)
                    debugPrint(response)
                    break
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }
    
    //// Get Storages
    func getStorages(token: String, callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "storages",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let storages = Mapper<TSStorage>().mapArray(JSONString: sJSONObj["data"]["storages"].rawString()!)
                    callback(success, storages as AnyObject)
                    debugPrint(response)
                    break
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }
    
    //// Get Trucks
    func getTrucks(token: String, callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "trucks",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let trucks = Mapper<TSTruck>().mapArray(JSONString: sJSONObj["data"]["trucks"].rawString()!)
                    callback(success, trucks as AnyObject)
                    debugPrint(response)
                    break
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }
    
    //// Get Prices
    func getPrices(token: String, callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "prices",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let prices = Mapper<TSPrice>().mapArray(JSONString: sJSONObj["data"]["prices"].rawString()!)
                    callback(success, prices as AnyObject)
                    debugPrint(response)
                    break
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }
    
    /// Get Vehicles per Contract
    func getVehicleList(contract_id: Int, token: String, callback: @escaping ((Bool, AnyObject?) ->())) {
        Alamofire.request(TSAPIURL + "contracts/\(contract_id)/vehicle_lists",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["api-token": token])
            .responseJSON { (response) in
                switch(response.result){
                case .success(let info):
                    let sJSONObj = JSON(info)
                    guard let success = sJSONObj["success"].bool, success else {
                        callback(false, sJSONObj["error_code"].string as AnyObject)
                        return
                    }
                    
                    let vehicles = Mapper<TSVehicle>().mapArray(JSONString: sJSONObj["data"]["vehicle_lists"].rawString()!)
                    callback(success, vehicles as AnyObject)
                    debugPrint(response)
                    break
                case .failure(let error):
                    callback(false, (error as Error).localizedDescription as AnyObject)
                    break
                }
        }
    }
    
}
