//
//  TSRemoveableImageView.swift
//  TowSlip
//
//  Created by a on 12/26/16.
//  Copyright © 2016 swordEdge. All rights reserved.
//

import UIKit
import Photos

protocol TSRemoveableImageViewDelegate {
    func closeButtonTapped(in tsRemoveableImageView: UIView, on closeButton: UIButton)
}

class TSRemoveableImageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    
    var delegate : TSRemoveableImageViewDelegate?
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    var view: UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TSRemoveableImageView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    private func getAssetThumbnail(asset: PHAsset, width: CGFloat, height: CGFloat) -> UIImage {
        let retinaScale = UIScreen.main.scale
        let retinaSquare = CGSize(width: width * retinaScale, height: height * retinaScale)
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail = UIImage()
        
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        
        manager.requestImage(for: asset, targetSize: retinaSquare, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    public func set(asset: PHAsset) {
        self.imgView.image = getAssetThumbnail(asset: asset, width: 90, height: 90)
        closeBtn.isHidden = false
    }

    @IBAction func closeBtnHandler(_ sender: Any) {
        guard let d = delegate else {
            return
        }
        
        self.imgView.image = nil
        closeBtn.isHidden = true
        
        d.closeButtonTapped(in: self, on: sender as! UIButton)
    }
}
