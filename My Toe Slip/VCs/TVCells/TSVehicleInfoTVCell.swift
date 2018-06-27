//
//  TSVehicleInfoTVCell.swift
//  Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSVehicleInfoTVCell: TSBaseTVCell {
    
    @IBOutlet weak var lblCellHeader: UILabel!
    @IBOutlet weak var cellHeaderView: UIView!
    
    @IBOutlet weak var lblReasonCaption: UILabel!
    @IBOutlet weak var lblLicensePlateCaption: UILabel!
    @IBOutlet weak var lblColorCaption: UILabel!
    @IBOutlet weak var lblMakeModelCaption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewsWithColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func cellIdentifier() -> String {
        return "VehicleInfoTVCell";
    }
    
    func setupViewsWithColor() {
        self.cellHeaderView.backgroundColor = TSUtils.UIColorFromHex(THEME_TABBAR_BGCOLOR)
        self.lblCellHeader.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblLicensePlateCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblColorCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblMakeModelCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblReasonCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
    }
    
}
