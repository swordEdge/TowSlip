//
//  TSSectionTypeTVCell.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSSectionTypeTVCell: TSBaseTVCell {

    @IBOutlet weak var lblSection: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblSection.textColor = TSUtils.UIColorFromHex(THEME_SECOND)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func cellIdentifier() -> String {
        return "SectionTypeTVCell";
    }

}
