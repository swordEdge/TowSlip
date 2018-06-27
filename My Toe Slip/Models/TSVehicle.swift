//
//  TSPrice.swift
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
     "id": 8,
     "contract_id": 1,
     "name": "Whitelist",
     "created_at": "2016-10-10 00:00:00",
     "user_id": 3,
     "status": null
 }
 */

class TSVehicle : TSModelBase,  Mappable {
    
    var id : Int!
    var contract_id : Int!
    var name : String!
    var user_id : Int!
    var status: String?
    var created_at : Date?
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        contract_id     <- map["contract_id"]
        name            <- map["name"]
        user_id         <- map["user_id"]
        status          <- map["status"]
        created_at      <- (map["created_at"], CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm:ss"))
    }
    
    override func parse(json: JSON) -> TSVehicle {
        let info = Mapper<TSVehicle>().map(JSONString: json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}
