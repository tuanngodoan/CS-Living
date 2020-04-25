//
//  BaseViewController.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configPresenter()
        initUI()
        initData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Layout view
    
    func setTitleViewWithDefaultLogo() {
        setTitleViewWithImage(imageTitle: "")
    }
    
    func setTitleViewWithImage(imageTitle: String) {
        
        let headerImage = UIImageView(image: UIImage(named: imageTitle))
        headerImage.contentMode = .scaleAspectFit
        headerImage.frame = CGRect(x: 0, y: 0, width: (headerImage.image?.size.width)!, height: (headerImage.image?.size.height)!)
        
        let headerView = UIView()
        headerView.frame = CGRect(x: (SCREEN_WIDTH_PORTRAIT - (headerImage.image?.size.width)!) / 2, y: 0, width: (headerImage.image?.size.width)!, height: (headerImage.image?.size.height)!)
        
        headerView.addSubview(headerImage)
        navigationItem.titleView = headerView
    }
    
    // MARK: - Setup Left button Navigation
    func setBackButtonWithImage(_ imageButtonName: String, withAction action: Selector) {
        let tmpButton = UIButton(type: .custom)
        //tmpButton.frame.size.width = temBack.size.width + tmpButton.frame.size.width;
        tmpButton.setImage(UIImage(named: imageButtonName), for: .normal)
        tmpButton.addTarget(self, action: action, for: .touchUpInside)
        tmpButton.sizeToFit()
        if imageButtonName == "" {
            tmpButton.showsTouchWhenHighlighted = false
        } else {
            tmpButton.showsTouchWhenHighlighted = true
        }
        tmpButton.adjustsImageWhenHighlighted = false
        tmpButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: tmpButton)
    }
    
    func setBackButtonWithTitle(_ title: String, withAction action: Selector) {
        let tmpButton = UIButton(type: .custom)
        tmpButton.setTitle(title, for: .normal)
        tmpButton.addTarget(self, action: action, for: .touchUpInside)
        tmpButton.sizeToFit()
        if title == "" {
            tmpButton.showsTouchWhenHighlighted = false
        } else {
            tmpButton.showsTouchWhenHighlighted = true
        }
        tmpButton.adjustsImageWhenHighlighted = false
        tmpButton.contentEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: tmpButton)
    }
    
    // MARK: - Setup Right button Navigation
    func setRightButtonWithImage(_ imageButtonName: String, withAction action: Selector) {
        let tmpButton = UIButton(type: .custom)
        tmpButton.setImage(UIImage(named: imageButtonName), for: .normal)
        tmpButton.addTarget(self, action: action, for: .touchUpInside)
        tmpButton.sizeToFit()
        if imageButtonName == "" {
            tmpButton.showsTouchWhenHighlighted = false
        } else {
            tmpButton.showsTouchWhenHighlighted = true
        }
        tmpButton.adjustsImageWhenHighlighted = false
        tmpButton.contentEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tmpButton)
    }
    
    func setRightButtonWithTitle(_ title: String, color: UIColor, action: Selector) {
        let tmpButton = UIButton(type: .custom)
        tmpButton.setTitle(title, for: .normal)
        tmpButton.setTitleColor(color, for: .normal)
        tmpButton.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 17)
        tmpButton.addTarget(self, action: action, for: .touchUpInside)
        tmpButton.sizeToFit()
        tmpButton.showsTouchWhenHighlighted = false
        tmpButton.adjustsImageWhenHighlighted = false
        tmpButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tmpButton)
    }
    
    func removeBackButton() {
        setBackButtonWithImage("icnEmpty", withAction: #selector(emptyAction))
    }
    
    func removeRightButton() {
        setRightButtonWithImage("icnEmpty", withAction: #selector(emptyAction))
    }
    
    @objc func emptyAction() {
        
    }
}

@objc extension BaseViewController {
    // MARK: - Init UI && Data
    func initUI() {

    }

    func initData() {

    }
    
    func configPresenter() {
        
    }
}

