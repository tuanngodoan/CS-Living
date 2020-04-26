//
//  HomeViewController.swift
//  CS-Living
//
//  Created by doanntuann on 4/25/20.
//

import UIKit

enum ButtonType: Int {
    case feeList                = 1000001 // bảng kê phí
    case feedback               = 1000002 // ý kiến yêu cầu
    case notify                 = 1000003 // thông báo
    case mediaInfomation        = 1000004 //thông tin phương tiện
    case demographicInformation = 1000005 // thông tin nhân khẩu
    case bookAService           = 1000006 // Đặt dịch vụ
    case forSale                = 1000007 //Cho thuê, bán
    case schedule               = 1000008 // Đặt lịch
    case pay                    = 1000009 // Thanh toán
}

class HomeViewController: UIViewController {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var apartmentLabel: UILabel!
    
    @IBOutlet weak var upgradeAccountView: UIView!
    
    @IBOutlet weak var adsView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView! //img: 77
    @IBOutlet weak var pageControl: UIPageControl!

    var thisWidth: CGFloat = 0
    var adsHeight: CGFloat = 130.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thisWidth = CGFloat(self.view.frame.width)
        collectionView.delegate = self
        collectionView.dataSource = self

        pageControl.hidesForSinglePage = true
    }
    
    @IBAction func functionButtonDidTouch(_ sender: UIButton) {
        let buttonType = ButtonType.init(rawValue: sender.tag)
        switch buttonType {
        case .feeList:
            // TODO:
            break
        case .feedback:
            // TODO:
            break
        case .notify:
            // TODO:
            break
        case .mediaInfomation:
            // TODO:
            break
        case .demographicInformation:
            // TODO:
            break
        case .bookAService:
            // TODO:
            break
        case .forSale:
            // TODO:
            break
        case .schedule:
            // TODO:
            break
        case .pay:
            // TODO:
            break
        case .none:
            break
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsBannerCollectionViewCell", for: indexPath) as? AdsBannerCollectionViewCell {
            let color = (Int.random(in: 0...1) == 1) ? UIColor.orange : UIColor.blue
            cell.adsBannerView.backgroundColor = color
            return cell
        }
        
        return UICollectionViewCell()
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        thisWidth = CGFloat(self.view.frame.width)
        return CGSize(width: thisWidth, height: self.adsHeight)
    }
}
