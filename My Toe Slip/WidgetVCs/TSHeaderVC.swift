//
//  TSHeaderVC.swift
//  My Toe Slip
//
//  Created by swordEdge on 10/16/15.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

import UIKit

class TSHeaderVC : UIViewController, UITextFieldDelegate {

    @IBOutlet weak var leftBackBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerTitleDescription: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    var delegate : TSHeaderVCDelegate! = nil
   
    var mTimer : Timer?
    
    var THEME_FIRST : UInt32 = 0
    var THEME_SECOND : UInt32 = 0
    var THEME_MAIN_BGCOLOR : UInt32 = 0
    var THEME_CARD_FIRST_BGCOLOR : UInt32 = 0
    var THEME_CARD_SECOND_BGCOLOR : UInt32 = 0
    var THEME_TABBAR_BGCOLOR : UInt32 = 0
    
    var isLightTheme : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Search textfield initialize
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: searchBtn.bounds.size.width + 7, height: searchTextField.bounds.size.height))
        searchTextField.leftView = paddingView;
        searchTextField.leftViewMode = UITextFieldViewMode.always;
        searchTextField.addTarget(self, action: #selector(textFieldEditChanged(textField:)), for: .editingChanged)
        
        let tapGesture4TouchupOutofTextfield : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TSHeaderVC.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture4TouchupOutofTextfield)
        
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
    
    func dismissKeyboard(){
        searchTextField.resignFirstResponder()
    }
    
    func setHeaderStyle(_ title: String, description: String!, leftbutton: String!, rightButton: String!) {
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
        } else if leftbutton.characters.count != 0 {
            if (leftbutton == "menuIcon") {
                leftBackBtn.setImage(UIImage(named: "menuIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST)) , for: .normal)
            } else {
                leftBackBtn.setImage(nil, for: .normal)
                leftBackBtn.setTitle(leftbutton, for: UIControlState.normal)
                leftBackBtn.setTitleColor(TSUtils.UIColorFromHex(THEME_FIRST), for: .normal)
            }
        } else {
            leftBackBtn.setImage(UIImage(named: "backIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST)), for: .normal)
        }
        
        if rightButton == nil {
            rightBtn.isHidden = true
        }else{
            if (rightButton == "plusIcon") {
                rightBtn.setImage(UIImage(named: "plusIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST)), for: .normal)
                rightBtn.setTitle("", for: UIControlState.normal)
            } else{
                rightBtn.setTitle(rightButton, for: UIControlState.normal)
                rightBtn.setTitleColor(TSUtils.UIColorFromHex(THEME_FIRST), for: .normal)
            }
        }
        
        self.searchTextField.backgroundColor = TSUtils.UIColorFromHex(THEME_TABBAR_BGCOLOR)
        self.searchBtn.setImage(UIImage(named: "searchIcon")?.imageWithColor(TSUtils.UIColorFromHex(THEME_SECOND)), for: .normal)
        headerTitle.isHidden = false
    }
    
    //// Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
    }
    
    func textFieldEditChanged(textField: UITextField) {
        if mTimer != nil {
            mTimer?.invalidate()
            mTimer = nil
        }

        mTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(searchStringChangeTimer(timer:)), userInfo: nil, repeats: false)
    }
    
    func searchStringChangeTimer(timer: Timer) {
        if delegate != nil {
            delegate.headerSearchTextFieldEditChanged(self)
        }
    }

    @IBAction func leftBackBtnClicked(_ sender: AnyObject) {
        if delegate != nil {
            delegate.headerLeftBackBtnClicked(self)
        }
    }

    @IBAction func rightBtnClicked(_ sender: AnyObject) {
        if delegate != nil {
            delegate.headerRightBtnClicked(self)
        }
    }
    
    @IBAction func searchBtnClicked(_ sender: AnyObject) {
        if delegate != nil {
            delegate.headerSearchBtnClicked(self)
        }
    }
    
}
protocol TSHeaderVCDelegate : NSObjectProtocol{
    func headerLeftBackBtnClicked(_ view: TSHeaderVC!)
    func headerRightBtnClicked(_ view: TSHeaderVC!)
    func headerSearchBtnClicked(_ view: TSHeaderVC!)
    func headerSearchTextFieldEditChanged(_ view: TSHeaderVC!)
}
