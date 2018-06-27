//
//  TSVehicleListVC.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSVehicleListVC: TSBaseVC {

    @IBOutlet weak var tv: UITableView!
    
    var selectedRow : Int = 0
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
        /// setup header view
        self.headerView.setHeaderStyle("VEHICLE LIST", description: nil, leftbutton: "menuIcon", rightButton: "plusIcon")
        
        let revealVC: SWRevealViewController = self.revealViewController()
        self.view.addGestureRecognizer(revealVC.tapGestureRecognizer())
        revealVC.tapGestureRecognizer().cancelsTouchesInView = false;
        revealVC.delegate = self
        
        /// setup table view
        tv.estimatedRowHeight = 190
        tv.rowHeight = UITableViewAutomaticDimension
    }
    
    ///// Filter
    func filterWithText(filterString : String, data: AnyObject?, callback:@escaping(([TSContract]?) ->())){
        guard let tmp = data as? [TSContract] else {
            return
        }
        
        if filterString == "" {
            callback(tmp)
            return
        }
        
        let filtered = tmp.filter { (c : TSContract) -> Bool in
            guard let name = c.name else { return false }
            
            if (name.lowercased().range(of: filterString.lowercased()) != nil) {
                return true
            } else {
                guard let notes = c.notes else { return false }
                
                return notes.lowercased().range(of: filterString.lowercased()) != nil
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
        TSDataHandler.getContracts { (contracts) in
            self.filterWithText(filterString: self.headerView.searchTextField.text!, data: contracts as AnyObject?) { (filtered) -> () in
                self._filteredData = filtered as AnyObject?
                
                if (filtered != nil && filtered!.count > 0) {
                    TSAPIHandler.sharedInstance.getVehicleList(contract_id: filtered![0].id, token: token) { (success, info) in
                        self.hideActivityIndicator()
                        if(!success as Bool) {
                            self.showAlert(info! as! String)
                        } else {
                            self._organizedData = info
                        }
                        
                        self.tv.reloadData()
                    }
                    
                } else {
                    self.hideActivityIndicator()
                    self.tv.reloadData()
                }
            }
        }
    }
}

///// Header Delegate
extension TSVehicleListVC {
    override func headerLeftBackBtnClicked(_ view: TSHeaderVC!) {
        self.revealViewController().revealToggle(view.leftBackBtn as Any!)
    }
    
    override func headerRightBtnClicked(_ view: TSHeaderVC!) {
        self.performSegue(withIdentifier: "Vehicle2AddVehicle", sender: nil)
    }
    
    override func headerSearchTextFieldEditChanged(_ view: TSHeaderVC!) {
        TSDataHandler.getContracts { (contracts) in
            self.filterWithText(filterString: self.headerView.searchTextField.text!, data: contracts as AnyObject?) { (filtered) -> () in
                self._filteredData = filtered as AnyObject?
                self._organizedData = nil
                self.selectedRow = -1
                
                self.tv.reloadData()
            }
        }
    }
}

extension TSVehicleListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tmpFilter = _filteredData else {
            return 0
        }
        
        let nRows = (tmpFilter as! [TSTow]).count
        
        guard let tmpOriganzed = _organizedData as? [TSVehicle] else {
            return nRows
        }
        
        guard tmpOriganzed.count > 0 else {
            return nRows
        }
        
        return  nRows + tmpOriganzed.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let tmpContracts = self._filteredData as! [TSContract]
        let tmpVehicles = self._organizedData as? [TSVehicle]
        
        guard row >= tmpContracts.count else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TSApartmentTVCell.cellIdentifier(), for: indexPath) as! TSApartmentTVCell
            cell.container.backgroundColor = TSUtils.UIColorFromHex((row % 2 == 0) ? THEME_CARD_FIRST_BGCOLOR : THEME_CARD_SECOND_BGCOLOR)
            cell.setupValue(self, indexPath: indexPath, contract: tmpContracts[row])
            return cell
        }
        
        guard row != tmpContracts.count else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TSSectionTypeTVCell.cellIdentifier(), for: indexPath) as! TSSectionTypeTVCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TSVehicleListTVCell.cellIdentifier(), for: indexPath) as! TSVehicleListTVCell
        cell.setupValue(delegate: self, indexPath: indexPath, vehicle: tmpVehicles![row - tmpContracts.count - 1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let tmpContracts = self._filteredData as! [TSContract]
        
        if (row < tmpContracts.count) {
            if (selectedRow != row) {
                
                if (selectedRow != -1) {
                    guard let originalCell = tableView.cellForRow(at: IndexPath(row: selectedRow, section: 0)) as? TSApartmentTVCell else { return }
                    originalCell.lblSelectedBadge.isHidden = true
                }
                
                guard let cell = tableView.cellForRow(at: indexPath) as? TSApartmentTVCell else { return }
                cell.lblSelectedBadge.isHidden = false
                
                selectedRow = row
                
                /////
                self.showActivityIndicator()
                TSAPIHandler.sharedInstance.getVehicleList(contract_id: tmpContracts[row].id, token: TSCacheHandler.sharedInstance.getSavedToken()!) { (success, info) in
                    self.hideActivityIndicator()
                    if(!success as Bool) {
                        self.showAlert(info! as! String)
                    } else {
                        self._organizedData = info
                    }
                    
                    self.tv.reloadData()
                    
                    if let d = self._organizedData as? [TSVehicle], d.count > 0 {
                        self.tv.scrollToRow(at: IndexPath(row: tmpContracts.count, section: 0), at: .top, animated: true)
                    }
                }
            } else {
                if let d = self._organizedData as? [TSVehicle], d.count > 0 {
                    self.tv.scrollToRow(at: IndexPath(row: tmpContracts.count, section: 0), at: .top, animated: true)
                }
            }
        }
    }
}
