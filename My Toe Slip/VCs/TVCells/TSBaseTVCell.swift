//
//  TSBaseTVCell.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSBaseTVCell: UITableViewCell {

    var THEME_FIRST : UInt32 = 0
    var THEME_SECOND : UInt32 = 0
    var THEME_MAIN_BGCOLOR : UInt32 = 0
    var THEME_CARD_FIRST_BGCOLOR : UInt32 = 0
    var THEME_CARD_SECOND_BGCOLOR : UInt32 = 0
    var THEME_TABBAR_BGCOLOR : UInt32 = 0
    
    var delegate : UIViewController? = nil
    var indexPath : IndexPath? = nil
    
    var isLightTheme : Bool = true
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //// Color update
        self.isLightTheme = UserDefaults.standard.value(forKey: "isLightTheme") as? Bool ?? true
        if (isLightTheme) {
            THEME_FIRST = LIGHT_THEME_FIRST
            THEME_SECOND = LIGHT_THEME_SECOND
            THEME_MAIN_BGCOLOR = LIGHT_THEME_MAIN_BGCOLOR
            THEME_CARD_FIRST_BGCOLOR = LIGHT_THEME_CARD_FIRST_BGCOLOR
            THEME_CARD_SECOND_BGCOLOR = LIGHT_THEME_CARD_SECOND_BGCOLOR
            THEME_TABBAR_BGCOLOR = LIGHT_THEME_TABBAR_BGCOLOR
        } else {
            THEME_FIRST = DARK_THEME_FIRST
            THEME_SECOND = DARK_THEME_SECOND
            THEME_MAIN_BGCOLOR = DARK_THEME_MAIN_BGCOLOR
            THEME_CARD_FIRST_BGCOLOR = DARK_THEME_CARD_FIRST_BGCOLOR
            THEME_CARD_SECOND_BGCOLOR = DARK_THEME_CARD_SECOND_BGCOLOR
            THEME_TABBAR_BGCOLOR = DARK_THEME_TABBAR_BGCOLOR
        }
        
        setupColorChange()
        setupShadowSettings()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupColorChange() {
        self.contentView.backgroundColor = TSUtils.UIColorFromHex(THEME_MAIN_BGCOLOR)
        if (self.containerView != nil) {
            self.containerView.backgroundColor = TSUtils.UIColorFromHex(THEME_CARD_FIRST_BGCOLOR)
        }
    }
    
    func setupShadowSettings() {
        if (self.containerView != nil) {
            self.containerView.layer.masksToBounds = false;
            self.containerView.layer.shadowColor = UIColor.black.cgColor;
            self.containerView.layer.shadowOffset = CGSize(width: 0, height: 1);
            self.containerView.layer.shadowOpacity = 0.5;
            self.containerView.layer.shadowRadius = 2
        }
    }
    
    func updateShadow() {
        guard self.containerView != nil else {
            return
        }
        let shadowPath: UIBezierPath = UIBezierPath(rect: self.containerView.bounds)
        self.containerView.layer.shadowPath = shadowPath.cgPath;
    }

}
