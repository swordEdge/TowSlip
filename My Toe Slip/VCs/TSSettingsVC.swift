//
//  TSSettingsVC.swift
//  My Toe Slip
//
//  Created by a on 10/19/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSSettingsVC: TSBaseVC {

    @IBOutlet weak var themeSelector: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.headerNonSearchView.setHeaderStyle("Settings", description: nil, leftbutton: "", rightButton: nil)
        themeSelector.isOn = isLightTheme
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func themeSelectorValueChanged(_ sender: AnyObject) {
        UserDefaults.standard.set(themeSelector.isOn, forKey: "isLightTheme")
        UserDefaults.standard.synchronize()
        
        self.setupColorChange()
        self.headerNonSearchView.setupColorChange()
        self.headerNonSearchView.setHeaderStyle("Settings", description: nil, leftbutton: "", rightButton: nil)
    }

    override func headerNonSearchLeftBackBtnClicked(_ view: TSHeaderNonSearchVC!){
        self.revealViewController().performSegue(withIdentifier: "sw_front", sender: nil)
    }
}
