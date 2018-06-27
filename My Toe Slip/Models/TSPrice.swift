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
     "id": 1,
     "name": "Regular Price",
     "amount": "28.00"
 }
 */

class TSPrice : TSModelBase,  Mappable {
    
    var id : Int!
    var name : String!
    var amount : String!
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        amount      <- map["amount"]
    }
    
    override func parse(json: JSON) -> TSPrice {
        let info = Mapper<TSPrice>().map(JSONString: json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}
