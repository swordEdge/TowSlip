//
//  GMMainNavVC.swift
//  GainsMaker
//
//  Created by swordEdge on 10/16/15.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

import UIKit

enum GMMORESCREEN {
    case screener
    case earning
    case settings
}

class TSMainNavVC : UITabBarController, UITabBarControllerDelegate {

    var THEME_FIRST : UInt32 = 0
    var THEME_SECOND : UInt32 = 0
    var THEME_MAIN_BGCOLOR : UInt32 = 0
    var THEME_CARD_FIRST_BGCOLOR : UInt32 = 0
    var THEME_CARD_SECOND_BGCOLOR : UInt32 = 0
    var THEME_TABBAR_BGCOLOR : UInt32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupColorChange()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///// Setup Color Change
    func setupColorChange() {
        //// Color update
        let isLightTheme : Bool = UserDefaults.standard.value(forKey: "isLightTheme") as? Bool ?? true
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
        
        self.tabBar.barTintColor = TSUtils.UIColorFromHex(THEME_TABBAR_BGCOLOR)
        self.tabBar.tintColor = TSUtils.UIColorFromHex((isLightTheme ? 0x46B864 : 0xFFFFFF))
        
        /// Build More Menu
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: TSUtils.UIColorFromHex((isLightTheme == true ? 0x585E65 :0xFFFFFF), alpha: 0.5)], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: TSUtils.UIColorFromHex((isLightTheme == true ? 0x46B864 : 0xFFFFFF), alpha: 1)], for:.selected)
        
        self.delegate = self
        
        for item in self.tabBar.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(TSUtils.UIColorFromHex((isLightTheme == true ? 0x585E65 : 0xFFFFFF), alpha: 0.5)).withRenderingMode(.alwaysOriginal)
            }
        }
    }
}

