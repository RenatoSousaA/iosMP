//
//  CommonViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 04/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

import Crashlytics

class CommonViewController: UIViewController {
    
    var backAction: (() -> Void)?
    
    let loadingIdentifier: String = "LoadingView"
    
    var loadingView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    private func configureLoading() {
        
        let view = UIView()
        view.accessibilityIdentifier = loadingIdentifier
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        view.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: UIScreen.main.bounds.size)
        
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.style = .whiteLarge
        
        let y = view.frame.height / 2 - indicator.frame.height / 2
        let x = view.frame.width / 2 - indicator.frame.height / 2
        
        let origin = CGPoint.init(x: x, y: y)
        indicator.frame = CGRect.init(origin: origin, size: indicator.frame.size)
        
        view.addSubview(indicator)
        
        self.loadingView = view
    }
    
    func showLoading() {
        
        if nil == self.loadingView {
            self.configureLoading()
        }
        
        if let view = self.loadingView {
            self.view.addSubview(view)
        }
    }
    
    func dismissLoading() {
        for view in self.view.subviews {
            if let identifier = view.accessibilityIdentifier, identifier == loadingIdentifier {
                view.removeFromSuperview()
            }
        }
    }
    
    private func setupToolbarColor() {
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = SupplierFlavors.navBarColor
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = SupplierFlavors.navBarColor
    }
    
    private func setupToolbarHelp() {
        let helpImage = UIImage.init(named: "ic_help")
        let helpButton = UIBarButtonItem.init(image: helpImage, style: .plain, target: self, action: #selector(helpTouched))
        helpButton.tintColor = SupplierFlavors.iconNavBar
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = helpButton
    }
    
    public func setupDefaultToolbar() {
        
        self.setupToolbarColor()
        
        self.setupToolbarHelp()
    }
    
    public func setupToolbarHeight(height: CGFloat) {
        
        let height: CGFloat = 150 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)

    }
    
    public func setupToolbarWithBackButton(showHelp: Bool, title: String) {
        
        self.setupToolbarWithBackButton(showHelp: showHelp)
        self.setupToolbarTitle(title: title)
    }
    
    public func setupToolbarWithBackButton(showHelp: Bool, action: (() -> Void)? = nil) {
        
        self.setupToolbarColor()
        self.backAction = action
        
        
        if showHelp {
            self.setupToolbarHelp()
        }
        
        let backImage = UIImage.init(named: "ic_arrow_back")
        let backButton = UIBarButtonItem.init(image: backImage, style: .plain, target: self, action: #selector(backTouched))
        backButton.tintColor = SupplierFlavors.iconNavBar
        
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = backButton
        
    }
    
    public func setupToolbarTitle(title: String) {

        var titleLabel = self.navigationItem.titleView as? UILabel
        
        if nil == titleLabel {
            titleLabel = UILabel.init(frame: CGRect.zero)
            titleLabel?.backgroundColor = UIColor.clear
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel?.shadowColor = UIColor.white.withAlphaComponent(0.5)
            
            titleLabel?.textColor = SupplierFlavors.iconNavBar
            self.navigationItem.titleView = titleLabel
        }
        
        titleLabel?.text = title
        titleLabel?.sizeToFit()
    }
    
    @objc private func helpTouched() {
        self.showHelp()
    }
    
    @objc private func backTouched() {
        if nil != self.backAction {
            self.backAction!()
        }
        self.dismiss(animated: true)
    }
    
    private func showHelp() {
        let helpController = HelpViewController()
        helpController.providesPresentationContextTransitionStyle = true
        helpController.definesPresentationContext = true
        helpController.modalPresentationStyle = .overCurrentContext
        helpController.modalTransitionStyle = .crossDissolve
        
        helpController.helpMessage = AppDelegate.helpText
        
        self.present(helpController, animated: true)
    }
    
    public func showCodeError(title: String, message: String, caption: String, action: (() -> Void)? = nil) {
        
        self.showCustomMessage(title: title, message: message, caption: caption, bannerType: .negative, action: action)
    }
    
    public func showSingleMessage(message: String, caption: String, bannerType: CustomMessageViewController.Banner, action: (() -> Void)? = nil) {
        
        let errorController = SingleMessageViewController()
        
        errorController.providesPresentationContextTransitionStyle = true
        errorController.definesPresentationContext = true
        errorController.modalPresentationStyle = .overCurrentContext
        errorController.modalTransitionStyle = .crossDissolve
        
        errorController.bannerType = bannerType
        errorController.message = message
        errorController.caption = caption
        
        if nil != action {
            errorController.actionCallback = action
        }
        
        self.present(errorController, animated: true)
    }
    
    public func showCustomMessage(title: String, message: String, caption: String, bannerType: CustomMessageViewController.Banner, action: (() -> Void)? = nil) {
        
//        Thread.sleep(forTimeInterval: 0.2)
        
        let errorController = CustomMessageViewController()
        errorController.providesPresentationContextTransitionStyle = true
        errorController.definesPresentationContext = true
        errorController.modalPresentationStyle = .overCurrentContext
        errorController.modalTransitionStyle = .crossDissolve
        
        errorController.bannerType = bannerType
        errorController.customTitle = title
        errorController.message = message
        errorController.caption = caption
        
        if nil != action {
            errorController.actionCallback = action
        }
        
        self.present(errorController, animated: true)
    }
    
    public func showCrashButton() {
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.backgroundColor = SupplierFlavors.blueTotvs
        button.setTitleColor(UIColor.white, for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }

    public func setOrientation(orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(Int(orientation.rawValue), forKey: "orientation")
    }

}
