//
//  TSAddNewVehicleVC.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit
import THCalendarDatePicker

class TSAddNewVehicleVC: TSBaseVC {
    @IBOutlet weak var tv: UITableView!
    
    var stickerDate: Date = Date()
    var towDate: Date = Date()
    lazy var stickerPicker : THDatePickerViewController = {
        var dp = THDatePickerViewController.datePicker()
        dp?.delegate = self
        dp?.setAllowClearDate(false)
        dp?.setClearAsToday(true)
        dp?.setAutoCloseOnSelectDate(false)
        dp?.setAllowSelectionOfSelectedDate(true)
        dp?.setDisableHistorySelection(false)
        dp?.setDisableFutureSelection(false)
        dp?.autoCloseCancelDelay = 2.0
        dp?.isRounded = true
        dp?.selectedBackgroundColor = UIColor(red: 125/255.0, green: 208/255.0, blue: 0/255.0, alpha: 1.0)
        dp?.currentDateColor = UIColor(red: 242/255.0, green: 121/255.0, blue: 53/255.0, alpha: 1.0)
        dp?.currentDateColorSelected = UIColor.yellow
        return dp!
    }()
    
    lazy var towPicker : THDatePickerViewController = {
        var dp = THDatePickerViewController.datePicker()
        dp?.delegate = self
        dp?.setAllowClearDate(false)
        dp?.setClearAsToday(true)
        dp?.setAutoCloseOnSelectDate(false)
        dp?.setAllowSelectionOfSelectedDate(true)
        dp?.setDisableHistorySelection(false)
        dp?.setDisableFutureSelection(false)
        dp?.autoCloseCancelDelay = 2.0
        dp?.isRounded = true
        dp?.selectedBackgroundColor = UIColor(red: 125/255.0, green: 208/255.0, blue: 0/255.0, alpha: 1.0)
        dp?.currentDateColor = UIColor(red: 242/255.0, green: 121/255.0, blue: 53/255.0, alpha: 1.0)
        dp?.currentDateColorSelected = UIColor.yellow
        return dp!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupViewsWithColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.headerNonSearchView.setHeaderStyle("Meadows Place Senior Village", description: "NewYork 1293 , ST. Steven", leftbutton: "", rightButton: "sendIcon", sideRightButtonShow: true )
    }
    
    func setupViewsWithColor() {
        
    }
}

extension TSAddNewVehicleVC {
    //// HeaderBar Delegate
    override func headerNonSearchLeftBackBtnClicked(_ view: TSHeaderNonSearchVC!) {
        self.dismissVC()
    }
    override func headerNonSearchRightBtnClicked(_ view: TSHeaderNonSearchVC!) {
        
    }
    override func headerNonSearchSideRightBtnClicked(_ view: TSHeaderNonSearchVC!) {
        
    }
}

extension TSAddNewVehicleVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: Int = indexPath.row
        
        guard row != 0 else { return 131 }
        guard row != 1 else { return 62 }
        
        return 296
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resCell : UITableViewCell;
        let row : Int = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TSAddVehicleDateTVCell.cellIdentifier(), for: indexPath) as! TSAddVehicleDateTVCell
            cell.setupValue(delegate: self, indexPath: indexPath)
            resCell = cell
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TSTapToAddTVCell.cellIdentifier(), for: indexPath) as! TSTapToAddTVCell
            resCell = cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TSVehicleInfoTVCell.cellIdentifier(), for: indexPath) as! TSVehicleInfoTVCell
            resCell = cell
        }
        
        return resCell
    }
}

extension TSAddNewVehicleVC : THDatePickerDelegate {
    public func datePickerDonePressed(_ datePicker: THDatePickerViewController!) {
        guard let cell = self.tv.cellForRow(at: IndexPath(row: 0, section: 0)) as? TSAddVehicleDateTVCell else {
            return
        }
        
        if datePicker == stickerPicker {
            self.stickerDate = datePicker.date
        } else {
            self.towDate = datePicker.date
        }
        
        cell.updateValue(stickerDate: self.stickerDate, towDate: self.towDate)
        datePicker.dismissSemiModalView()
    }
    
    public func datePickerCancelPressed(_ datePicker: THDatePickerViewController!) {
        guard let cell = self.tv.cellForRow(at: IndexPath(row: 0, section: 0)) as? TSAddVehicleDateTVCell else {
            return
        }
        
        if datePicker == stickerPicker {
            self.stickerDate = Date()
        } else {
            self.towDate = Date()
        }
        
        cell.updateValue(stickerDate: self.stickerDate, towDate: self.towDate)
        datePicker.dismissSemiModalView()
    }
}
