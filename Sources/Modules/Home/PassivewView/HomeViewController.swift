//
//  HomeViewController.swift
//  CS-Living
//
//  Created by doanntuann on 4/25/20.
//

import UIKit

class HomeViewController: BaseViewController {

    private var presenter: HomePresenter!
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var apartmentLabel: UILabel!
    
    @IBOutlet weak var upgradeAccountView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView! //img: 77
    @IBOutlet weak var pageControl: UIPageControl!

    private var thisWidth: CGFloat = 0
    private var adsHeight: CGFloat = 135
    private var dummyAds: [String] = ["img_ads1", "img_ads2", "img_ads3", "img_ads4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        

//        self.title = "Trang chủ"
    }
    
    @objc func upgradeAccountDidTouch() {
        self.presenter.goUpgradeAccountVC()
    }
    
    @IBAction func functionButtonDidTouch(_ sender: UIButton) {
        let buttonType = ButtonHomeType.init(rawValue: sender.tag)
        switch buttonType {
        case .feeList:
            let feeListVC = FeeListViewController.controller(from: "FeeList", storyboardID: "FeeListViewController")
            self.navigationController?.pushViewController(feeListVC, animated: true)
            // TODO:
            break
        case .feedback:
            // TODO:
            break
        case .notify:
            let notifiVC = NotificationViewController.controller(from: "Notification", storyboardID: "NotificationViewController")
            self.navigationController?.pushViewController(notifiVC, animated: true)
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

// MARK: - Init View
extension HomeViewController {
    override func initUI() {
        super.initUI()
        self.setupAdsCollectionView()
        self.setupUpgradeAccView()
    }
    
    func setupAdsCollectionView() {
        thisWidth = CGFloat(self.view.frame.width)
        collectionView.register(UINib(nibName: "AdsBannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsBannerCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.hidesForSinglePage = true
    }
    
    func setupUpgradeAccView() {
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(upgradeAccountDidTouch))
        self.upgradeAccountView.isUserInteractionEnabled = true
        self.upgradeAccountView.addGestureRecognizer(tapHandler)
    }
}

// MARK: - Init Data
extension HomeViewController {
    override func initData() {

    }
}

// MARK: - ConfigPresenter
extension HomeViewController {
    override func configPresenter() {
        self.presenter = HomePresenter.init(view: self)
    }
}

// MARK: - Private func
extension HomeViewController {
    
}

// MARK: - Public func
extension HomeViewController {
    
}

// MARK: - API CALL
extension HomeViewController {
    
}

// MARK: - LoginPresenterView
extension HomeViewController: HomePresenterView {
    func goUpgradeAccountVC() {
        if let upgradeAccVC = UpgradeAccountViewController.controller(from: "Home", storyboardID: "UpgradeAccountViewController") as? UpgradeAccountViewController {
            self.navigationController?.pushViewController(upgradeAccVC, animated: true)
        }
    }
}

// MARK: - Ads CollectionView
extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = self.dummyAds.count
        return self.dummyAds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsBannerCollectionViewCell", for: indexPath) as? AdsBannerCollectionViewCell  {
                cell.setAdsView(imageName: self.dummyAds[indexPath.row])
                return cell
            }
        
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        thisWidth = CGFloat(self.view.frame.width)
        return CGSize(width: thisWidth, height: self.adsHeight)
    }
}

