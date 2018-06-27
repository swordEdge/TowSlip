//
//  TSContract.swift
//  ToeSlip
//
//  Created by a on 12/11/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

/*
 {
     "id": 5,
     "manager_id": 14,
     "name": "ABC Apartments",
     "address": "123 ABC St",
     "phone": "7135551234",
     "status": 0,
     "city": "KL",
     "state": "Petaling",
     "zip": "10000",
     "gate_code": "gcode",
     "authorized_by": "someone",
     "email1": "mat1@mat.com",
     "email2": "mat1@mat.com",
     "notes": "notes"
 }
 */

class TSContract : TSModelBase,  Mappable {
    
    var id : Int!
    var manager_id : Int!
    var name : String?
    var address : String?
    var phone : String?
    var status : Int!
    var city : String?
    var state : String?
    var zip : String?
    var gate_code : String?
    var authorized_by: String?
    var email1 : String?
    var email2 : String?
    var notes : String?
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id                      <- map["id"]
        manager_id              <- map["manager_id"]
        name                    <- map["name"]
        address                 <- map["name"]
        phone                   <- map["phone"]
        status                  <- map["status"]
        city                    <- map["city"]
        state                   <- map["state"]
        zip                     <- map["zip"]
        gate_code               <- map["gate_code"]
        authorized_by           <- map["authorized_by"]
        email1                  <- map["email1"]
        email2                  <- map["email2"]
        notes                   <- map["notes"]
    }
    
    override func parse(json: JSON) -> TSContract {
        let info = Mapper<TSContract>().map(JSONString: json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}
