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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
