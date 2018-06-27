//
//  TSTruck.swift
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
     "name": "Small giant",
     "license": "ABC-1011",
     "driver_id": 2
 }
 */

class TSTruck : TSModelBase,  Mappable {
    
    var id : Int!
    var name : String!
    var license : String!
    var driver_id : Int!
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        license     <- map["license"]
        driver_id   <- map["driver_id"]
    }
    
    override func parse(json: JSON) -> TSTruck {
        let info = Mapper<TSTruck>().map(JSONString: json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}
