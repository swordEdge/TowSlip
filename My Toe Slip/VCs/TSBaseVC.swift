//
//  GMBaseVC.swift
//  GainsMaker
//
//  Created by swordEdge on 10/16/15.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

import Foundation
import UIKit

class TSBaseVC : UIViewController, SWRevealViewControllerDelegate {
    
    var tapGesture4TouchupOutofTextfield : UITapGestureRecognizer!
    
    var _organizedData : AnyObject?
    var _filteredData : AnyObject?
    var _search : String! = ""
    
    var THEME_FIRST : UInt32 = 0
    var THEME_SECOND : UInt32 = 0
    var THEME_MAIN_BGCOLOR : UInt32 = 0
    var THEME_CARD_FIRST_BGCOLOR : UInt32 = 0
    var THEME_CARD_SECOND_BGCOLOR : UInt32 = 0
    var THEME_TABBAR_BGCOLOR : UInt32 = 0
    var THEME_HEADER_BGCOLOR : UInt32 = 0
    
    var isLightTheme : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture4TouchupOutofTextfield = UITapGestureRecognizer(target: self, action: #selector(TSBaseVC.dismissKeyboardfromSearchTextField))
        tapGesture4TouchupOutofTextfield.cancelsTouchesInView = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupColorChange()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///// Setup Color Change
    func setupColorChange() {
        self.isLightTheme = UserDefaults.standard.value(forKey: "isLightTheme") as? Bool ?? true
        if (isLightTheme) {
            THEME_FIRST = LIGHT_THEME_FIRST
            THEME_SECOND = LIGHT_THEME_SECOND
            THEME_MAIN_BGCOLOR = LIGHT_THEME_MAIN_BGCOLOR
            THEME_CARD_FIRST_BGCOLOR = LIGHT_THEME_CARD_FIRST_BGCOLOR
            THEME_CARD_SECOND_BGCOLOR = LIGHT_THEME_CARD_SECOND_BGCOLOR
            THEME_TABBAR_BGCOLOR = LIGHT_THEME_TABBAR_BGCOLOR
            THEME_HEADER_BGCOLOR = LIGHT_THEME_HEADER_BGCOLOR
        } else {
            THEME_FIRST = DARK_THEME_FIRST
            THEME_SECOND = DARK_THEME_SECOND
            THEME_MAIN_BGCOLOR = DARK_THEME_MAIN_BGCOLOR
            THEME_CARD_FIRST_BGCOLOR = DARK_THEME_CARD_FIRST_BGCOLOR
            THEME_CARD_SECOND_BGCOLOR = DARK_THEME_CARD_SECOND_BGCOLOR
            THEME_TABBAR_BGCOLOR = DARK_THEME_TABBAR_BGCOLOR
            THEME_HEADER_BGCOLOR = DARK_THEME_HEADER_BGCOLOR
        }
        
        self.view.backgroundColor = TSUtils.UIColorFromHex(THEME_MAIN_BGCOLOR)
    }
    
    /////////////////// Activity Indicatior Implementation /////////////////////
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivityIndicator(_ backgroundColor : UInt32 = 0x555C65) {
        let uiView : UIView! = self.view
        
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = TSUtils.UIColorFromHex(backgroundColor, alpha: 0.5)
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: uiView.frame.size.width / 2, y: uiView.frame.size.height / 2);
        
        container.addSubview(activityIndicator)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func dismissKeyboardfromSearchTextField(){
        if headerView != nil {
            headerView.searchTextField.resignFirstResponder()
        }        
    }
    
    func showAlert(_ message: String, title : String = "My Toe Slip", buttonTitle: String = "OK") {
        
        let editedMessage = message
        
        let refreshAlert = UIAlertController(title: title, message: editedMessage, preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    var headerView : TSHeaderVC! = nil
    var headerNonSearchView : TSHeaderNonSearchVC! = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "HeaderNonSearchEmbed") {
            headerNonSearchView = segue.destination as! TSHeaderNonSearchVC
            headerNonSearchView.delegate = self
        }
        else if(segue.identifier == "HeaderEmbed") {
            headerView = segue.destination as! TSHeaderVC
            headerView.delegate = self
        }
    }
    
    func dismissVC() {
        if let navVC = self.navigationController {
            navVC.popViewController(animated: true)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func animateTable(_ tableView: UITableView) {
        tableView.reloadData()        
        
        let indexPathsforVisibleRows = tableView.indexPathsForVisibleRows
        let tableHeight: CGFloat = tableView.bounds.size.height
        var animateViews : [(Bool,AnyObject)] = [(Bool,AnyObject)]()
        
        if (indexPathsforVisibleRows?.count)! > 0 {
            if let headerView = tableView.headerView(forSection: 0) {
                 animateViews.append((true,headerView))
                 headerView.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            }
        }
        
        var index = 0
        
        for indexPath in indexPathsforVisibleRows! {
            if indexPath.section != index {
                if let headerView = tableView.headerView(forSection: indexPath.section) {
                    animateViews.append((true,headerView))
                    headerView.transform = CGAffineTransform(translationX: 0, y: tableHeight)
                    index = indexPath.section
                }
            }else if let cell = tableView.cellForRow(at: indexPath) as UITableViewCell? {
                animateViews.append((false,cell))
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            }
        }
        
        index = 0
        
        for view in animateViews {
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                if view.0 {
                    let cell : UITableViewHeaderFooterView = view.1 as! UITableViewHeaderFooterView
                    cell.transform = CGAffineTransform.identity
                }else{
                    let cell : UITableViewCell = view.1 as! UITableViewCell
                    cell.transform = CGAffineTransform.identity
                }
            }, completion: nil)
            index += 1
        }
    }
    
    func updateAlphaValue(_ alpha : CGFloat)
    {
        self.headerView.searchTextField.alpha = alpha
        self.headerView.searchBtn.alpha = alpha
    }
    
    func animateNavBarTo(_ y : CGFloat, scrollView : UIScrollView)
    {
        UIView.animate(withDuration: 0.2, animations: {
            var frameSearchTextField : CGRect = self.headerView.searchTextField.frame
            let alpha : CGFloat = (frameSearchTextField.origin.y >= y ? 0 : 1)
            frameSearchTextField.origin.y = y
            self.headerView.searchTextField.frame = frameSearchTextField
            self.updateAlphaValue(alpha)
            
            var frameScrollView : CGRect = scrollView.frame
            frameScrollView.origin.y = y + 30
            frameScrollView.size.height = TSUtils.heightOfScreen() - 49 - frameScrollView.origin.y
            scrollView.frame = frameScrollView
        });
    }
    
    var previousScrollViewYOffset : CGFloat = 0
    func scrolling(_ scrollView : UIScrollView, isSortPanel : Bool = false){
        if !isSortPanel && _search.characters.count == 0 {
            self.headerView.view.sendSubview(toBack: self.headerView.searchTextField)
            var frame = self.headerView.searchTextField.frame
            let framePercentageHidden : CGFloat = ((77 - frame.origin.y) / 35);
            let scrollOffset : CGFloat = scrollView.contentOffset.y;
            let scrollDiff : CGFloat = scrollOffset - self.previousScrollViewYOffset;
            let scrollHeight : CGFloat = scrollView.frame.size.height;
            let scrollContentSizeHeight : CGFloat = scrollView.contentSize.height + scrollView.contentInset.bottom;
            
            var frameSearchBtn = self.headerView.searchBtn.frame
            
            var frameScrollView = scrollView.frame
            
            if (scrollOffset <= -scrollView.contentInset.top) { // Down
                frame.origin.y = 77
            } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) { // Up
                frame.origin.y = 37
            } else {
                frame.origin.y = min(77, max(37, frame.origin.y - scrollDiff));
            }

            frameSearchBtn.origin.y = frame.origin.y + 8
            
            frameScrollView.origin.y = frame.origin.y + 30
            frameScrollView.size.height = TSUtils.heightOfScreen() - 49 - frameScrollView.origin.y

            self.headerView.searchBtn.frame = frameSearchBtn
            self.headerView.searchTextField.frame = frame
            scrollView.frame = frameScrollView
            
            self.updateAlphaValue(1 - framePercentageHidden)
            self.previousScrollViewYOffset = scrollOffset;
        }
    }
    
    func stoppedScrolling(_ scrollView : UIScrollView)
    {
        let frame = self.headerView.searchTextField.frame
        if (frame.origin.y < 77) {
            self.animateNavBarTo(37, scrollView: scrollView)
        }
    }
    
    func validateTextFieldAndShowMessage(_ textField: UITextField, errorMsg: String) -> Bool {
        if(textField.text!.isEmpty) {
            self.showAlert(errorMsg)
            return false
        }
        return true
    }
    
    func validatePasswordLengthAndShowMessage(_ textField: UITextField, errorMsg: String) -> Bool {
        if(textField.text!.characters.count < 8) {
            self.showAlert(errorMsg)
            return false
        }
        return true
    }
    
}

extension TSBaseVC : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TSBaseVC : TSHeaderVCDelegate {
    func headerNonSearchLeftBackBtnClicked(_ view: TSHeaderNonSearchVC!){
        
    }
    
    func headerNonSearchRightBtnClicked(_ view: TSHeaderNonSearchVC!){
        
    }
    
    func headerNonSearchSideRightBtnClicked(_ view: TSHeaderNonSearchVC!){
        
    }
}

extension TSBaseVC : TSHeaderNonSearchVCDelegate {
    func headerLeftBackBtnClicked(_ view: TSHeaderVC!){
        
    }
    
    func headerRightBtnClicked(_ view: TSHeaderVC!){
        
    }
    
    func headerSearchBtnClicked(_ view: TSHeaderVC!){
        
    }
    
    func headerSearchTextFieldEditChanged(_ view: TSHeaderVC!) {
        
    }
}
