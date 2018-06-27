//
//  TSHistoryVC.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSHistoryVC: TSBaseVC {

    @IBOutlet weak var tv: UITableView!
    var storageIDs : [Int]?
    var storages: [TSStorage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tv.backgroundColor = TSUtils.UIColorFromHex(THEME_MAIN_BGCOLOR)
        fetchDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    func initUI() {
        /// setup haeder view
        self.headerView.setHeaderStyle("HISTORY", description: nil, leftbutton: "menuIcon", rightButton: "plusIcon")
        
        let revealVC: SWRevealViewController = self.revealViewController()
        self.view.addGestureRecognizer(revealVC.tapGestureRecognizer())
        revealVC.tapGestureRecognizer().cancelsTouchesInView = false;
        revealVC.delegate = self
        
        /// setup tableView
        tv.estimatedRowHeight = 250
        tv.rowHeight = UITableViewAutomaticDimension
        
        TSDataHandler.getPrices { (prices) in }
    }
    
    ///// Filter
    func filterWithText(filterString : String, data: AnyObject?, callback:@escaping(([TSTow]?) ->())){
        guard let tmp = data as? [TSTow] else {
            return
        }
        
        if filterString == "" {
            callback(tmp)
            return
        }
        
        let filtered = tmp.filter { (t : TSTow) -> Bool in
            guard let make = t.make else { return false }
            
            if (make.lowercased().range(of: filterString.lowercased()) != nil) {
                return true
            } else {
                guard let model = t.model else { return false }
                
                return model.lowercased().range(of: filterString.lowercased()) != nil
            }
        }
        
        callback(filtered)
    }
    
    ////// Api Call
    func fetchDataFromServer() {
        guard let token = TSCacheHandler.sharedInstance.getSavedToken() else {
            return
        }
        
        self.showActivityIndicator()
        TSDataHandler.getStorages { (storages) in
            self.storages = storages
            if storages != nil, storages!.count > 0 {
                self.storageIDs = storages!.map({ (s : TSStorage) -> Int in
                    return s.id
                })
            }
            
            TSAPIHandler.sharedInstance.getTows(token: token) { (success, info) -> () in
                self.hideActivityIndicator()
                if(!success as Bool) {
                    self.showAlert(info! as! String)
                } else {
                    self._organizedData = info
                    
                    self.filterWithText(filterString: self.headerView.searchTextField.text!, data: self._organizedData) { (filtered) -> () in
                        
                        self._filteredData = filtered as AnyObject?
                        self.tv.reloadData()
                    }
                }
            }
        }
    }
}

extension TSHistoryVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tmp = _filteredData else {
            return 0
        }
        
        return (tmp as! [TSTow]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resCell : UITableViewCell;
        let row = indexPath.row
        let tow = (self._filteredData as! [TSTow])[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TSHistoryTVCell.cellIdentifier(), for: indexPath) as! TSHistoryTVCell
        
        if self.storages != nil, self.storages!.count > 0 {
            if let found = self.storageIDs!.index(of: tow.storage_id!) {
                cell.setupValue(delegate: self, indexPath: indexPath, tow: tow, storage: self.storages![found])
            } else {
                cell.setupValue(delegate: self, indexPath: indexPath, tow: tow, storage: nil)
            }
        } else {
            cell.setupValue(delegate: self, indexPath: indexPath, tow: tow, storage: nil)
        }
            
        resCell = cell
        return resCell
    }
    
    ///// Header Delegate
    override func headerLeftBackBtnClicked(_ view: TSHeaderVC!) {
        self.revealViewController().revealToggle(view.leftBackBtn as Any!)
    }
    
    override func headerRightBtnClicked(_ view: TSHeaderVC!) {
        self.performSegue(withIdentifier: "history2AddTow", sender: nil)
    }
    
    override func headerSearchTextFieldEditChanged(_ view: TSHeaderVC!) {
        self.filterWithText(filterString: self.headerView.searchTextField.text!, data: self._organizedData) { (filtered) -> () in
            
            self._filteredData = filtered as AnyObject?
            self.tv.reloadData()
        }
    }
}
