//
//  AdsBannerCollectionViewCell.swift
//  CS-Living
//
//  Created by doanntuann on 4/26/20.
//

import UIKit

class AdsBannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adsBannerView: UIView!
    @IBOutlet weak var adsBannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setAdsView(imageName: String) {
        let image = UIImage(named: imageName)
        self.adsBannerImageView.image = image
    }

}
