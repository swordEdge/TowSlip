//
//  TSStorage.swift
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
     "id": 2,
     "name": "name",
     "address": "address",
     "city": "city",
     "state": "state",
     "zip": "zip",
     "phone": "phone",
     "email": "email@example.com"
 }
 */

class TSStorage : TSModelBase,  Mappable {
    
    var id : Int!
    var name : String!
    var address : String!
    var city : String!
    var state : String!
    var zip : String!
    var phone : String!
    var email : String!
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        address     <- map["address"]
        city        <- map["city"]
        state       <- map["state"]
        zip         <- map["zip"]
        phone       <- map["phone"]
        email       <- map["email"]
    }
    
    override func parse(json: JSON) -> TSStorage {
        let info = Mapper<TSStorage>().map(JSONString: json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}
