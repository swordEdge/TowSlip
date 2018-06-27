//
//  TSUserCredentialInfo.swift
//  ToeSlip
//
//  Created by a on 12/11/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

//////// SUCCESS ////////*
/*
 {
     "success": true,
     "data": {
         "user_id": 2,
         "name": "Driver One",
         "username": "driver1",
         "role": "Driver"
     }
 }
 */

class TSUser : TSModelBase,  Mappable, NSCoding {
    
    var user_id : Int!
    var name : String!
    var username : String!
    var role : String!
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        user_id       <- map["user_id"]
        name          <- map["name"]
        username      <- map["username"]
        role          <- map["role"]
    }
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? EMPTY_STRING
        self.username = decoder.decodeObject(forKey: "username") as? String ?? EMPTY_STRING
        self.role = decoder.decodeObject(forKey: "role") as? String ?? EMPTY_STRING
        self.user_id = UserDefaults.standard.object(forKey: "user_id") as! Int
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(username, forKey: "username")
        coder.encode(role, forKey: "role")
        //coder.encode(user_id, forKey: "user_id")
        UserDefaults.standard.set(user_id, forKey: "user_id")
        UserDefaults.standard.synchronize()
    }
    
    override func parse(json: JSON) -> TSUser {
        let info = Mapper<TSUser>().map(JSONString: json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}
