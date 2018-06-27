//
//  TSModelBase.swift
//  ToeSlip
//
//  Created by a on 12/11/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import Foundation
import SwiftyJSON

class TSModelBase: NSObject {
    
    func parse(json : JSON) -> TSModelBase {
        return self
    }
    
    func serialize() -> String? {
        return nil;
    }
    
    func generateDictionary() -> [String: Any] {
        return [String: Any]()
    }
}
