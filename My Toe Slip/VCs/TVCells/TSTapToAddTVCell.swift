//
//  TSTapToAddTVCell.swift
//  Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSTapToAddTVCell: TSBaseTVCell {
    
    @IBOutlet weak var lblTapToAdd: UILabel!
    @IBOutlet weak var imgPlusIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewsWithColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func cellIdentifier() -> String {
        return "TapToAddTVCell";
    }
    
    func setupViewsWithColor() {
        self.containerView.backgroundColor = TSUtils.UIColorFromHex(THEME_TABBAR_BGCOLOR)
        self.imgPlusIcon.image = UIImage(named: "plusIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST))
        self.lblTapToAdd.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
    }
    
}
