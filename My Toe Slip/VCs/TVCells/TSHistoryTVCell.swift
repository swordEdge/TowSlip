//
//  TSHistoryTVCell.swift
//  My Toe Slip
//
//  Created by a on 10/18/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit

class TSHistoryTVCell: TSBaseTVCell {

    @IBOutlet weak var lblTowIndex: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStorage: UILabel!
    @IBOutlet weak var lblTowDate: UILabel!
    @IBOutlet weak var lblTowBy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewsWithColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func cellIdentifier() -> String {
        return "HistoryTVCell";
    }
    
    func setupViewsWithColor() {
        lblTitle.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
        lblStorage.textColor = TSUtils.UIColorFromHex(THEME_SECOND)
        lblNote.textColor = TSUtils.UIColorFromHex(THEME_FIRST)
    }
    
    func setupValue(delegate: TSHistoryVC, indexPath: IndexPath, tow: TSTow, storage: TSStorage?) {
        self.delegate = delegate
        self.indexPath = indexPath
        
        lblTowIndex.text = "\(tow.id!)"
        lblTitle.text = (tow.make ?? EMPTY_STRING) + " " + (tow.model ?? EMPTY_STRING) + ((tow.color != nil) ? " (" + tow.color! + ")" : EMPTY_STRING)
        lblNote.text = "Note: " + (tow.notes ?? EMPTY_STRING)
        lblTowBy.text = (tow.towed_from != nil) ? "from " + tow.towed_from! : EMPTY_STRING
        lblTowDate.text = tow.tow_date != nil ? Date.date2String(date: tow.tow_date!) : EMPTY_STRING
        lblStorage.text = (storage == nil ? EMPTY_STRING : storage!.name)
        
        ///// Add Style
        TSUtils.insertStyle2Label(label: lblNote, params: [
            ("font", 0, 5, UIFont(name: "Lato-BoldItalic", size: 14)!)
            ])
    }

}
