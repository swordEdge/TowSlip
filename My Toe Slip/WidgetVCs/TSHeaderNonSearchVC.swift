
//
//  TSHeaderNonSearchVC.swift
//  My Toe Slip
//
//  Created by swordEdge on 10/16/15.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

import UIKit

class TSHeaderNonSearchVC : UIViewController {

    
    @IBOutlet weak var leftBackBtn: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerTitleDescription: UILabel!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var sideRightBtn: UIButton!
    
    var delegate : TSHeaderNonSearchVCDelegate! = nil
    
    var THEME_FIRST : UInt32 = 0
    var THEME_SECOND : UInt32 = 0
    var THEME_MAIN_BGCOLOR : UInt32 = 0
    var THEME_CARD_FIRST_BGCOLOR : UInt32 = 0
    var THEME_CARD_SECOND_BGCOLOR : UInt32 = 0
    var THEME_TABBAR_BGCOLOR : UInt32 = 0
    
    var isLightTheme : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorChange()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupColorChange() {
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
    }
    
    func setHeaderStyle(_ title: String, description: String!, leftbutton: String!, rightButton: String!, sideRightButtonShow: Bool = false, titleTappable: Bool = true) {
        self.view.backgroundColor = TSUtils.UIColorFromHex(THEME_MAIN_BGCOLOR)
        headerTitle.text = title
        headerTitle.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        
        if description == nil {
            headerTitleDescription.isHidden = true
        }else{
            headerTitleDescription.text = description
            headerTitleDescription.textColor = TSUtils.UIColorFromHex(THEME_SECOND)
        }
        
        if leftbutton == nil {
            leftBackBtn.isHidden = true
        }else if leftbutton.characters.count != 0 {
            leftBackBtn.setTitle(leftbutton, for: UIControlState.normal)
            leftBackBtn.setTitleColor(TSUtils.UIColorFromHex(THEME_FIRST), for: .normal)
        } else {
            leftBackBtn.setImage(UIImage(named: "backIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST)), for: .normal)
        }
        
        if rightButton == nil {
            rightBtn.isHidden = true
        } else {
            if (rightButton == "sendIcon") {
                rightBtn.setImage(UIImage(named: "sendIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST)), for: .normal)
                rightBtn.setTitle("", for: UIControlState.normal)
            } else {
                rightBtn.setTitle(rightButton, for: UIControlState.normal)
                rightBtn.setTitleColor(TSUtils.UIColorFromHex(THEME_FIRST), for: .normal)
            }
        }
        
        if (titleTappable) {
            headerTitle.isUserInteractionEnabled = true
            let tapGestureOnTitle : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftBackBtnClicked(_:)))
            headerTitle.addGestureRecognizer(tapGestureOnTitle)
        }
        
        sideRightBtn.isHidden = !sideRightButtonShow
        sideRightBtn.setImage(UIImage(named: "saveIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST)), for: .normal)
        
        headerTitle.isHidden = false
    }
    
    @IBAction func leftBackBtnClicked(_ sender: AnyObject) {
        if delegate != nil {
            delegate.headerNonSearchLeftBackBtnClicked(self)
        }
    }

    @IBAction func rightBtnClicked(_ sender: AnyObject) {
        if delegate != nil {
            delegate.headerNonSearchRightBtnClicked(self)
        }
    }

    @IBAction func sideRightBtnClicked(_ sender: AnyObject) {
        if delegate != nil {
            delegate.headerNonSearchSideRightBtnClicked(self)
        }
    }
    
}

protocol TSHeaderNonSearchVCDelegate {
    func headerNonSearchLeftBackBtnClicked(_ view: TSHeaderNonSearchVC!)
    func headerNonSearchRightBtnClicked(_ view: TSHeaderNonSearchVC!)
    func headerNonSearchSideRightBtnClicked(_ view: TSHeaderNonSearchVC!)
}

