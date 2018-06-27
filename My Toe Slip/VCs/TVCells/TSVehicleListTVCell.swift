//
//  TSVehicleListTVCell.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSVehicleListTVCell: TSBaseTVCell {

    @IBOutlet weak var lblVehicleIndex: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReturnDate: UILabel!
    @IBOutlet weak var lblVehicleDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewsWithColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViewsWithColor() {
        lblTitle.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        lblReturnDate.textColor = TSUtils.UIColorFromHex(THEME_SECOND)
    }

    static func cellIdentifier() -> String {
        return "VehicleListTVCell";
    }
    
    func setupValue(delegate : TSVehicleListVC, indexPath: IndexPath, vehicle : TSVehicle) {
        self.delegate = delegate
        self.indexPath = indexPath
        
        self.lblVehicleIndex.text = "\(vehicle.id!)"
        self.lblTitle.text = (vehicle.name ?? EMPTY_STRING)
        self.lblVehicleDate.text = (vehicle.created_at != nil) ? Date.date2String(date: vehicle.created_at!) : EMPTY_STRING
    }
}
