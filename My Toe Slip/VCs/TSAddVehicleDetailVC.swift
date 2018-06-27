//
//  TSAddVehicleDetailVC.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit
import MKDropdownMenu
import CTAssetsPickerController

class TSAddVehicleDetailVC: TSBaseVC {
    
    @IBOutlet var btnReasons: [UIButton]!
    @IBOutlet weak var lblVehicleInfo: UILabel!
    @IBOutlet weak var lblMakeModelCaption: UILabel!
    @IBOutlet weak var lblColorCaption: UILabel!
    @IBOutlet weak var lblLicensePlateCaption: UILabel!
    @IBOutlet weak var txtMakeModel: AutoCompleteTextField!
    @IBOutlet weak var txtLicense: UITextField!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblPhotos: UILabel!
    @IBOutlet weak var btnAddPhoto: UIButton!
    @IBOutlet weak var txtOtherReason: UITextField!
    @IBOutlet weak var colorSelectDropDown: MKDropdownMenu!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var colorString : String = "Beige"
    var isSelectedForReasons : [Bool] = [false, false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewsWithColor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.colorSelectDropDown.closeAllComponents(animated: true)
//        NotificationCenter.default.removeObserver(Notification.Name.UIKeyboardWillShow)
//        NotificationCenter.default.removeObserver(Notification.Name.UIKeyboardDidHide)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.headerNonSearchView.setHeaderStyle("ADD VEHICLE", description: nil, leftbutton: "", rightButton: "Done")
        
        configureAutoCompleteTextField()
        handleAutoCompleteTextFieldInterfaces()
        
        self.colorSelectDropDown.delegate = self
        self.colorSelectDropDown.dataSource = self
        
        self.txtLicense.delegate = self
        self.txtMakeModel.delegate = self
        self.txtOtherReason.delegate = self
        self.txtLicense.addTarget(self, action: #selector(textFieldEditChanged(textField:)), for: .editingChanged)
        
        //// Add Shadow
        self.btnAddPhoto.layer.masksToBounds = false;
        self.btnAddPhoto.layer.shadowColor = UIColor.black.cgColor;
        self.btnAddPhoto.layer.shadowOffset = CGSize(width: 0, height: 1);
        self.btnAddPhoto.layer.shadowOpacity = 0.5;
        self.btnAddPhoto.layer.shadowRadius = 2
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func setupViewsWithColor() {
        for (index, b) in self.btnReasons.enumerated() {
            b.addTarget(self, action: #selector(btnReasonsTapped(_:)), for: .touchUpInside)
            b.setImage(UIImage(named: "ovalIcon_" + (isSelectedForReasons[index] ? "full": "empty") + "_" + (self.isLightTheme ? "light" : "dark")), for: .normal)
            b.setTitleColor(TSUtils.UIColorFromHex(THEME_FIRST), for: .normal)
        }
        
        self.lblMakeModelCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblColorCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblLicensePlateCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblPhotos.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblReason.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblVehicleInfo.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtMakeModel.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtLicense.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        
        self.btnAddPhoto.setTitleColor(TSUtils.UIColorFromHex(THEME_FIRST), for: .normal)
        self.btnAddPhoto.backgroundColor = TSUtils.UIColorFromHex(THEME_TABBAR_BGCOLOR)
        self.txtOtherReason.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        
        self.colorSelectDropDown.disclosureIndicatorImage = UIImage(named: "triangle")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST))
    }
    
    //// AutoComplete Handler
    private func configureAutoCompleteTextField(){
        
        //// Contract
        txtMakeModel.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        txtMakeModel.autoCompleteTextFont = UIFont(name: "Lato-Regular", size: 12.0)!
        txtMakeModel.autoCompleteCellHeight = 30
        txtMakeModel.maximumAutoCompleteCount = 20
        txtMakeModel.hidesWhenSelected = true
        txtMakeModel.hidesWhenEmpty = true
        txtMakeModel.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.black //TSUtils.UIColorFromHex(THEME_FIRST)
        attributes[NSFontAttributeName] = UIFont(name: "Lato-Regular", size: 14.0)
        txtMakeModel.autoCompleteAttributes = attributes
        txtMakeModel.delegate = self
    }
    
    private func handleAutoCompleteTextFieldInterfaces(){
        
        txtMakeModel.onTextChange = {[weak self] text in
            
            let autoCompletedMakeModels = AVAILABLE_MAKE_MODEL.filter({ (mm : String) -> Bool in
                return mm.lowercased().range(of: text.lowercased()) != nil
            })
            
            self?.txtMakeModel.autoCompleteStrings = autoCompletedMakeModels
        }
        
        txtMakeModel.onSelect = {[weak self] text, indexpath in
            self?.txtMakeModel.text = text
        }
    }
    
    //// Action Handler
    @IBAction func btnReasonsTapped(_ sender: Any) {
        let b : UIButton = sender as! UIButton
        let index : Int = b.tag
        isSelectedForReasons[index] = !isSelectedForReasons[index]
        
        b.setImage(UIImage(named: "ovalIcon_" + (isSelectedForReasons[index] ? "full": "empty") + "_" + (self.isLightTheme ? "light" : "dark")), for: .normal)
    }
    
    @IBAction func btnAddPhotosTapped(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
            DispatchQueue.main.async {
                let picker : CTAssetsPickerController = CTAssetsPickerController()
                picker.delegate = self
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
                    picker.modalPresentationStyle = UIModalPresentationStyle.formSheet
                }
                
                self.present(picker, animated: true, completion: nil)
            }
        }
    }
}

/*
extension TSAddVehicleDetailVC {
    func keyboardWillShow() {
        
    }
    
    func keyboardDidHide() {
        
    }
}
*/

extension TSAddVehicleDetailVC {
    func textFieldEditChanged(textField: UITextField) {
        guard textField == self.txtLicense else {
            return
        }
        
        let tmp = textField.text!
        textField.text = tmp.uppercased() + (tmp.characters.count == 3 ? "-" : EMPTY_STRING)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == self.txtLicense else {
            return true
        }
        
        guard string != "" else {
            return true
        }
        
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        
        guard let c = string.unicodeScalars.first else {
            return false
        }
        guard (letters.contains(c) || digits.contains(c)) else {
            return false
        }
        
        let text = textField.text! as NSString
        let shouldDidEditEnd = text.replacingCharacters(in: range, with: string)
        
        guard shouldDidEditEnd.characters.count <= 8 else {
            return false
        }
        
        return true
    }
}

extension TSAddVehicleDetailVC {
    //// HeaderBar Delegate
    override func headerNonSearchLeftBackBtnClicked(_ view: TSHeaderNonSearchVC!) {
        self.dismissVC()
    }
    override func headerNonSearchRightBtnClicked(_ view: TSHeaderNonSearchVC!) {
        
    }
    override func headerNonSearchSideRightBtnClicked(_ view: TSHeaderNonSearchVC!) {
        
    }
}

extension TSAddVehicleDetailVC : MKDropdownMenuDataSource, MKDropdownMenuDelegate {
    public func numberOfComponents(in dropdownMenu: MKDropdownMenu) -> Int {
        return 1
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, numberOfRowsInComponent component: Int) -> Int {
        return AVAILABLE_COLORS.count
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: self.colorString, attributes: [
            NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!,
            NSForegroundColorAttributeName: TSUtils.UIColorFromHex(THEME_FIRST)
            ])
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: AVAILABLE_COLORS[row], attributes: [
            NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!,
            NSForegroundColorAttributeName: UIColor.black
            ])
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, didSelectRow row: Int, inComponent component: Int) {
        self.colorString = AVAILABLE_COLORS[row]
        dropdownMenu.closeAllComponents(animated: true)
        dropdownMenu.reloadAllComponents()
    }

}

extension TSAddVehicleDetailVC : CTAssetsPickerControllerDelegate {
    public func assetsPickerController(_ picker: CTAssetsPickerController!, didFinishPickingAssets assets: [Any]!) {
        
    }
}


