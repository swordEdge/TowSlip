//
//  TSAddTowVC.swift
//  ToeSlip
//
//  Created by swordEdge on 10/16/15.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

import UIKit
import THCalendarDatePicker
import MKDropdownMenu
import CTAssetsPickerController

class TSAddTowVC : TSBaseVC {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var lblVehicleInfo: UILabel!
    @IBOutlet weak var lblContracts: UILabel!
    @IBOutlet weak var txtContractsAutoComplete: AutoCompleteTextField!
    @IBOutlet weak var txtMakeModelAutoComplete: AutoCompleteTextField!
    @IBOutlet weak var colorSelectDropDown: MKDropdownMenu!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var lblYearCaption: UILabel!
    @IBOutlet weak var lblMakeModelCaption: UILabel!
    @IBOutlet weak var lblColorCaption: UILabel!
    @IBOutlet weak var lblVinCaption: UILabel!
    @IBOutlet weak var txtVin: UITextField!
    @IBOutlet weak var lblLicensePlate: UILabel!
    @IBOutlet weak var txtLicense: UITextField!
    
    @IBOutlet weak var lblNoteCaption: UILabel!
    @IBOutlet weak var txtNote: UITextField!
    @IBOutlet weak var lblReasonCaption: UILabel!
    
    @IBOutlet weak var lblPhotosCaption: UILabel!
    @IBOutlet weak var lblChargeCaption: UILabel!
    @IBOutlet weak var btnAddPhoto: UIButton!
    
    @IBOutlet weak var reasonSelectDropDown: MKDropdownMenu!
    @IBOutlet weak var chargeSelectDropDown: MKDropdownMenu!
    
    @IBOutlet var tsRIViews: [TSRemoveableImageView]!

    var prices : [TSPrice]?
    let availableReasons : [String] = ["Expired Inspection", "wrecked", "expired plates", "float tires", "inoperable", "on Blocks", "No Permit", "Non-Matching Permit", "Reserved Space", "Unregistered/Unauthorized Vehicle", "Unauthorized Visitor", "Fire Lane", "Handicapped", "Missing parts", "Abandoned"]
    var colorString : String = "Beige"
    var reasonString : String = "Expired Inspection"
    
    var chargeString : String = ""
    var selectedChargeNumber : Int = -1
    
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
        self.reasonSelectDropDown.closeAllComponents(animated: true)
        self.chargeSelectDropDown.closeAllComponents(animated: true)
        
//        NotificationCenter.default.removeObserver(Notification.Name.UIKeyboardWillShow)
//        NotificationCenter.default.removeObserver(Notification.Name.UIKeyboardDidHide)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initUI() {
        self.headerNonSearchView.setHeaderStyle("ADD TOW", description: nil, leftbutton: "", rightButton: "Done")
        configureAutoCompleteTextField()
        handleAutoCompleteTextFieldInterfaces()
        
        self.colorSelectDropDown.delegate = self
        self.colorSelectDropDown.dataSource = self
        self.reasonSelectDropDown.delegate = self
        self.reasonSelectDropDown.dataSource = self
        self.chargeSelectDropDown.delegate = self
        self.chargeSelectDropDown.dataSource = self
        
        self.txtNote.delegate = self
        self.txtLicense.delegate = self
        self.txtVin.delegate = self
        self.txtYear.delegate = self
        self.txtLicense.addTarget(self, action: #selector(textFieldEditChanged(textField:)), for: .editingChanged)
        self.txtVin.addTarget(self, action: #selector(textFieldEditChanged(textField:)), for: .editingChanged)
        
        //// Add Shadow
        self.btnAddPhoto.layer.masksToBounds = false;
        self.btnAddPhoto.layer.shadowColor = UIColor.black.cgColor;
        self.btnAddPhoto.layer.shadowOffset = CGSize(width: 0, height: 1);
        self.btnAddPhoto.layer.shadowOpacity = 0.5;
        self.btnAddPhoto.layer.shadowRadius = 2
        
        TSDataHandler.getPrices { (prices) in
            self.prices = prices
            guard self.prices != nil, self.prices!.count > 0 else {
                return
            }
            
            self.chargeString = self.prices![0].name ?? EMPTY_STRING
            self.selectedChargeNumber = 0
        }
        
        for tsRIView in tsRIViews {
            tsRIView.delegate = self
        }
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func setupViewsWithColor() {
        self.lblVehicleInfo.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblContracts.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblMakeModelCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblColorCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblVinCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblLicensePlate.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblYearCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtContractsAutoComplete.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtYear.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtMakeModelAutoComplete.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtVin.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtLicense.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        
        
        self.lblReasonCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblChargeCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.lblNoteCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.txtNote.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        
        self.lblPhotosCaption.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        self.btnAddPhoto.setTitleColor(TSUtils.UIColorFromHex(THEME_FIRST), for: .normal)
        self.btnAddPhoto.backgroundColor = TSUtils.UIColorFromHex(THEME_TABBAR_BGCOLOR)
        
        self.colorSelectDropDown.disclosureIndicatorImage = UIImage(named: "triangle")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST))
        self.reasonSelectDropDown.disclosureIndicatorImage = UIImage(named: "triangle")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST))
        self.chargeSelectDropDown.disclosureIndicatorImage = UIImage(named: "triangle")?.imageWithColor(TSUtils.UIColorFromHex(THEME_FIRST))
    }
    
    //// AutoComplete Handler
    private func configureAutoCompleteTextField(){
        
        //// Contract
        txtContractsAutoComplete.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        txtContractsAutoComplete.autoCompleteTextFont = UIFont(name: "Lato-Regular", size: 12.0)!
        txtContractsAutoComplete.autoCompleteCellHeight = 30
        txtContractsAutoComplete.maximumAutoCompleteCount = 20
        txtContractsAutoComplete.hidesWhenSelected = true
        txtContractsAutoComplete.hidesWhenEmpty = true
        txtContractsAutoComplete.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.black
        attributes[NSFontAttributeName] = UIFont(name: "Lato-Regular", size: 14.0)
        txtContractsAutoComplete.autoCompleteAttributes = attributes
        txtContractsAutoComplete.delegate = self
        
        ///// Make Model
        txtMakeModelAutoComplete.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        txtMakeModelAutoComplete.autoCompleteTextFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
        txtMakeModelAutoComplete.autoCompleteCellHeight = 35.0
        txtMakeModelAutoComplete.maximumAutoCompleteCount = AVAILABLE_MAKE_MODEL.count
        txtMakeModelAutoComplete.hidesWhenSelected = true
        txtMakeModelAutoComplete.hidesWhenEmpty = true
        txtMakeModelAutoComplete.enableAttributedText = true
        txtMakeModelAutoComplete.autoCompleteAttributes = attributes
        txtMakeModelAutoComplete.delegate = self
    }
    
    private func handleAutoCompleteTextFieldInterfaces(){
        txtContractsAutoComplete.onTextChange = {[weak self] text in
            TSDataHandler.getContracts(callback: { (contracts) in
                
                guard let autoCompletedContracts = contracts?.filter({ (c : TSContract) -> Bool in
                    guard let name = c.name else {
                        return false
                    }
                    
                    return name.lowercased().range(of: text.lowercased()) != nil
                }) else {
                    return
                }
                
                let autoCompletedStrings = autoCompletedContracts.map({ (c : TSContract) -> String in
                    return c.name ?? EMPTY_STRING
                })
                
                self?.txtContractsAutoComplete.autoCompleteStrings = autoCompletedStrings
            })
        }
        
        txtContractsAutoComplete.onSelect = {[weak self] text, indexpath in
            self?.txtContractsAutoComplete.text = text
        }
        
        txtMakeModelAutoComplete.onTextChange = {[weak self] text in
            
            let autoCompletedMakeModels = AVAILABLE_MAKE_MODEL.filter({ (mm : String) -> Bool in
                return mm.lowercased().range(of: text.lowercased()) != nil
            })
            
            self?.txtMakeModelAutoComplete.autoCompleteStrings = autoCompletedMakeModels
        }
        
        txtMakeModelAutoComplete.onSelect = {[weak self] text, indexpath in
            self?.txtMakeModelAutoComplete.text = text
        }
    }
    
    @IBAction func btnAddPhotoTapped(_ sender: Any) {
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
    
    func dismissKeybaord() {
        txtYear.resignFirstResponder()
        txtVin.resignFirstResponder()
        txtNote.resignFirstResponder()
        txtLicense.resignFirstResponder()
        txtContractsAutoComplete.resignFirstResponder()
        txtMakeModelAutoComplete.resignFirstResponder()
    }
}

/*
extension TSAddTowVC {
    func keyboardWillShow() {
        let frame = mainScrollView.frame
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.mainScrollView.frame = CGRect(x: frame.origin.x, y: frame.origin.y - 200, width: frame.size.width, height: frame.size.height)
        })
    }
    
    func keyboardDidHide() {
        let frame = mainScrollView.frame
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.mainScrollView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + 200, width: frame.size.width, height: frame.size.height)
        })
    }
}
*/

extension TSAddTowVC {
    func textFieldEditChanged(textField: UITextField) {
        let tmp = textField.text!
        if (textField == txtVin) {
            textField.text = tmp.uppercased()
        } else {
            textField.text = tmp.uppercased() + (tmp.characters.count == 3 ? "-" : EMPTY_STRING)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == self.txtLicense || textField == self.txtVin || textField == self.txtYear else {
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
        
        var allowedLen = 0
        if (textField == self.txtYear) {
            guard digits.contains(c) else {
                return false
            }
            
            allowedLen = 4
        } else {
            guard (letters.contains(c) || digits.contains(c)) else {
                return false
            }
            
            allowedLen = (textField == self.txtLicense ? 8 : 17)
        }
        
        let text = textField.text! as NSString
        let shouldDidEditEnd = text.replacingCharacters(in: range, with: string)
        
        guard shouldDidEditEnd.characters.count <= allowedLen else {
            return false
        }
        
        return true
    }
}

extension TSAddTowVC {
    //// HeaderBar Delegate
    override func headerNonSearchLeftBackBtnClicked(_ view: TSHeaderNonSearchVC!) {
        self.dismissVC()
    }
    
    override func headerNonSearchRightBtnClicked(_ view: TSHeaderNonSearchVC!) {
        guard let token = TSCacheHandler.sharedInstance.getSavedToken() else {
            self.showAlert("Session Expired, please login again.")
            return
        }
        
        guard let me = TSCacheHandler.sharedInstance.getSavedMeInfo() else {
            self.showAlert("Cannot your user information, please contact support.")
            return
        }
        
        let make_model = txtMakeModelAutoComplete.text!
        guard make_model.characters.count > 0 else {
            self.showAlert("Please specify Make/Model.")
            return
        }
        
        let year = txtYear.text!
        guard year.characters.count > 0 else {
            self.showAlert("Please specify year.")
            return
        }
        
        let license = txtLicense.text!
        guard license.characters.count > 0 else {
            self.showAlert("Please specify License.")
            return
        }
        
        let arrMakeModel = make_model.components(separatedBy: " / ")
        let make = arrMakeModel[0]
        let model = arrMakeModel.count > 1 ? arrMakeModel[1] : EMPTY_STRING
        
        let towData = [
            "tow_date": Date.date2String(date: Date()),
            "make": make,
            "model": model,
            "color": self.colorString,
            "license": license,
            "towed_from": "towed_from",
            "reason": self.reasonString,
            "driver_id": me.user_id,
            "storage_id": 2,
            "price_id": self.prices![selectedChargeNumber].id,
            "contract_id": 5
        ] as [String : Any]
        
        self.showActivityIndicator()
        TSAPIHandler.sharedInstance.postTow(token: token, towData: towData) { (success, info) in
            self.hideActivityIndicator()
            if(!success as Bool) {
                self.showAlert(info! as! String)
            } else {
                self.dismissVC()
            }
        }
    }
    
    override func headerNonSearchSideRightBtnClicked(_ view: TSHeaderNonSearchVC!) {
        
    }
}

extension TSAddTowVC : MKDropdownMenuDelegate, MKDropdownMenuDataSource {
    public func numberOfComponents(in dropdownMenu: MKDropdownMenu) -> Int {
        return 1
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, numberOfRowsInComponent component: Int) -> Int {
        if dropdownMenu == self.colorSelectDropDown {
            return AVAILABLE_COLORS.count
        } else if dropdownMenu == self.reasonSelectDropDown {
            return availableReasons.count
        } else {
            return self.prices == nil ? 0 : self.prices!.count
        }
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForComponent component: Int) -> NSAttributedString? {
        var initString : String = "Tap to Select"
        if dropdownMenu == self.colorSelectDropDown {
            initString = self.colorString
        } else if dropdownMenu == self.reasonSelectDropDown {
            initString = self.reasonString
        } else {
            initString = chargeString
        }
        
        return NSAttributedString(string: initString, attributes: [
            NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!,
            NSForegroundColorAttributeName: TSUtils.UIColorFromHex(THEME_FIRST)
            ])
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var tmp : String = ""
        if dropdownMenu == self.colorSelectDropDown {
            tmp = AVAILABLE_COLORS[row]
        } else if dropdownMenu == self.reasonSelectDropDown {
            tmp = availableReasons[row]
        } else {
            tmp = self.prices![row].name ?? EMPTY_STRING
        }
        
        return NSAttributedString(string: tmp, attributes: [
            NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!,
            NSForegroundColorAttributeName: UIColor.black
            ])
    }
    
    public func dropdownMenu(_ dropdownMenu: MKDropdownMenu, didSelectRow row: Int, inComponent component: Int) {
        if dropdownMenu == self.colorSelectDropDown {
            self.colorString = AVAILABLE_COLORS[row]
        } else if dropdownMenu == self.reasonSelectDropDown {
            self.reasonString = availableReasons[row]
        } else {
            self.chargeString = self.prices![row].name ?? EMPTY_STRING
            self.selectedChargeNumber = row
        }
        
        dropdownMenu.closeAllComponents(animated: true)
        dropdownMenu.reloadAllComponents()
    }
}

extension TSAddTowVC : CTAssetsPickerControllerDelegate {
    public func assetsPickerController(_ picker: CTAssetsPickerController!, didFinishPickingAssets assets: [Any]!) {
        picker.dismiss(animated: true) {
            guard assets.count > 0 else {
                return
            }

            for (index, asset) in assets.enumerated() {
                self.tsRIViews[index].set(asset: asset as! PHAsset)
            }
        }
    }
    
    public func assetsPickerController(_ picker: CTAssetsPickerController!, shouldSelect asset: PHAsset!) -> Bool {
        return (picker.selectedAssets.count < 7);
    }
}

extension TSAddTowVC : TSRemoveableImageViewDelegate {
    
    func closeButtonTapped(in tsRemoveableImageView: UIView, on closeButton: UIButton) {
        
    }
}
