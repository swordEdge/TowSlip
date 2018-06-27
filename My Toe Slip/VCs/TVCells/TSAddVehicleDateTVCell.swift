//
//  TSAddVehicleDateTVCell.swift
//  Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit
import THCalendarDatePicker

class TSAddVehicleDateTVCell: TSBaseTVCell {
    
    @IBOutlet weak var lblCellHeader: UILabel!
    @IBOutlet weak var cellHeaderView: UIView!
    
    @IBOutlet weak var lblStickerDateCaption: UILabel!
    @IBOutlet weak var lblStickerDateValue: UILabel!
    @IBOutlet weak var lblTowDateCaption: UILabel!
    @IBOutlet weak var lblTowDateValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewsWithColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func cellIdentifier() -> String {
        return "AddVehicleDateTVCell";
    }
    
    func setupViewsWithColor() {
        self.cellHeaderView.backgroundColor = TSUtils.UIColorFromHex(THEME_TABBAR_BGCOLOR)
        self.lblCellHeader.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblStickerDateCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblTowDateCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
    }
    
    func setupValue(delegate: TSAddNewVehicleVC, indexPath: IndexPath) {
        self.delegate = delegate
        self.indexPath = indexPath
        
        guard let homeVC : TSAddNewVehicleVC = self.delegate as? TSAddNewVehicleVC else {
            return
        }
        
        self.lblStickerDateValue.text = Date.date2String(date: homeVC.stickerDate)
        self.lblTowDateValue.text = Date.date2String(date: homeVC.towDate)
    }
    
    func updateValue(stickerDate: Date, towDate: Date) {
        self.lblStickerDateValue.text = Date.date2String(date: stickerDate)
        self.lblTowDateValue.text = Date.date2String(date: towDate)
    }
    
    @IBAction func btnStickerDateEditTapped(_ sender: Any) {
        guard let homeVC : TSAddNewVehicleVC = self.delegate as? TSAddNewVehicleVC else {
            return
        }
        
        homeVC.stickerPicker.date = homeVC.stickerDate
        homeVC.stickerPicker.setDateHasItemsCallback({(date : Date?) -> Bool in
            let tmp = (arc4random() % 30) + 1
            return tmp % 5 == 0
        })
        homeVC.presentSemiViewController(homeVC.stickerPicker, withOptions: [
            KNSemiModalOptionKeys.pushParentBack.takeUnretainedValue() : NSNumber(value: false),
            KNSemiModalOptionKeys.animationDuration.takeUnretainedValue() : NSNumber(value: 0.5),
            KNSemiModalOptionKeys.shadowOpacity.takeUnretainedValue() : NSNumber(value: 0.3)
            ])
    }
    
    @IBAction func btnTowDateEditTapped(_ sender: Any) {
        guard let homeVC : TSAddNewVehicleVC = self.delegate as? TSAddNewVehicleVC else {
            return
        }
        
        homeVC.towPicker.date = homeVC.towDate
        homeVC.towPicker.setDateHasItemsCallback({(date : Date?) -> Bool in
            let tmp = (arc4random() % 30) + 1
            return tmp % 5 == 0
        })
        homeVC.presentSemiViewController(homeVC.towPicker, withOptions: [
            KNSemiModalOptionKeys.pushParentBack.takeUnretainedValue() : NSNumber(value: false),
            KNSemiModalOptionKeys.animationDuration.takeUnretainedValue() : NSNumber(value: 0.5),
            KNSemiModalOptionKeys.shadowOpacity.takeUnretainedValue() : NSNumber(value: 0.3)
            ])
    }
}
