//
//  GMLoginVC.swift
//  GainsMaker
//
//  Created by swordEdge on 10/16/15.
//  Copyright © 2015 mobilosophy LLC. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class TSLoginVC : TSBaseVC {


    @IBOutlet weak var txtUsername: JVFloatLabeledTextField!
    @IBOutlet weak var txtPassword: JVFloatLabeledTextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var txtPasswordInpuitBottomBar: UIImageView!
    @IBOutlet weak var txtEmailInputBottomBar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        guard (TSCacheHandler.sharedInstance.getSavedToken() == nil) else {
            self.performSegue(withIdentifier: "loginSuccess", sender: nil)
            return
        }
        
        // View Init
        txtUsername.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Utils
    func login(){
        
        if(!self.validateTextFieldAndShowMessage(txtUsername, errorMsg: "Please specify Email address") ||
            !self.validateTextFieldAndShowMessage(txtPassword, errorMsg:"Please specify Password"))
        {
            return;
        }
        
        self.showActivityIndicator()
        TSAPIHandler.sharedInstance.login(txtUsername.text!, password: txtPassword.text!) { (success, info) -> () in
            
            if(!success as Bool) {
                self.hideActivityIndicator()
                self.showAlert(info!)
            }
            else {
                TSCacheHandler.sharedInstance.saveToken(token: info!)
                TSAPIHandler.sharedInstance.getMe(token: info!) { (success, me) in
                    self.hideActivityIndicator()
                    if(!success as Bool) {
                        self.showAlert(me as! String)
                    } else {
                        TSCacheHandler.sharedInstance.saveMeInfo(me: me as! TSUser)
                        self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                    }
                }
            }
        }
    }
    
    /// Event Handler
    
    @IBAction func btnLoginTapped(_ sender: AnyObject) {
        login()
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: AnyObject) {
        
    }

}

