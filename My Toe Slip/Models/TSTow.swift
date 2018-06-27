//
//  TSTow.swift
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
    "id": 36,
    "admin_id": 13,
    "contract_id": 5,
    "tow_date": "0000-00-00 00:00:00",
    "make": "Acura",
    "model": "CL",
    "color": "Beige",
    "license": "256-5966",
    "towed_from": "towed_from",
    "reason": "Expired Inspection",
    "storage_id": 1,
    "driver_id": 3,
    "price_id": 1,
    "notes": "",
    "vin": ""
}
*/

class TSTow : TSModelBase,  Mappable {
    
    var id : Int!
    var admin_id : Int!
    var contract_id : Int!
    var tow_date : Date?
    var make : String?
    var model : String?
    var color : String?
    var license : String?
    var towed_from : String?
    var reason : String?
    var storage_id : Int?
    var driver_id : Int?
    var price_id : Int?
    var notes : String?
    var vin : String?
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        admin_id            <- map["admin_id"]
        contract_id         <- map["contract_id"]
        tow_date            <- (map["tow_date"], CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm:ss"))
        make                <- map["make"]
        model               <- map["model"]
        color               <- map["color"]
        license             <- map["license"]
        towed_from          <- map["towed_from"]
        reason              <- map["reason"]
        storage_id          <- map["storage_id"]
        driver_id           <- map["driver_id"]
        price_id            <- map["price_id"]
        notes               <- map["notes"]
        vin                 <- map["vin"]
    }
    
    override func parse(json: JSON) -> TSTow {
        let info = Mapper<TSTow>().map(JSONString: json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}
