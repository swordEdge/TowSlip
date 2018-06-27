//
//  TSApartmentTVCell.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSApartmentTVCell: TSBaseTVCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSelectedBadge: UILabel!
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
        lblDescription.textColor = TSUtils.UIColorFromHex(THEME_SECOND)
    }
    
    func setupValue(_ delegate: TSVehicleListVC, indexPath: IndexPath, contract: TSContract) {
        self.delegate = delegate
        self.indexPath = indexPath
        
        self.lblSelectedBadge.isHidden = (self.indexPath?.row != delegate.selectedRow)
        
        self.lblTitle.text = contract.name ?? EMPTY_STRING
        self.lblDescription.text = contract.notes ?? EMPTY_STRING
    }
    
    static func cellIdentifier() -> String {
        return "ApartmentTVCell";
    }

}
