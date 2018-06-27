//
//  TSSideBarVC.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSSideBarVC: UIViewController {

    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblLogout: UILabel!
    @IBOutlet weak var lblSettings: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapOnSetting : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(settingsRevealTapped(_:)))
        self.lblSettings.addGestureRecognizer(tapOnSetting)
        let tapOnLogout : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoutRevealTapped(_:)))
        self.lblSettings.addGestureRecognizer(tapOnLogout)
        
        guard let me = TSCacheHandler.sharedInstance.getSavedMeInfo() else {
            return
        }
        
        lblUsername.text = me.username
        lblRole.text = me.role
        lblCompany.text = EMPTY_STRING
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func settingsRevealTapped(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "settingsReveal", sender: nil)
    }
    
    @IBAction func logoutRevealTapped(_ sender: Any) {
        TSCacheHandler.sharedInstance.resetToken()
        TSCacheHandler.sharedInstance.resetMeInfo()
        self.performSegue(withIdentifier: "logoutReveal", sender: nil)
    }
    
}
