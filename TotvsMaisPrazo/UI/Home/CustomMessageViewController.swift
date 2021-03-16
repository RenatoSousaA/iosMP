//
//  CustomMessageViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class CustomMessageViewController: UIViewController {
    
    var actionCallback: (() -> Void)?
    
    enum Banner {
        case clear
        case positive
        case negative
    }
    
    var customTitle: String?
    var message: String?
    var caption: String?
    
    var bannerType: CustomMessageViewController.Banner = Banner.clear
    
    // Outlets
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var messageContent: UITextView!
    
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupComponents()
    }
    
    override func viewDidLayoutSubviews() {
        self.messageContent.scrollRangeToVisible(NSRange.init(location: 0, length: 1))
    }
    
    private func setupComponents() {
        
        self.setupOverlay()
        
//        var tipoCliente = "";
        var nameError = "";
        var nameSuccess = "";
        
//        if let _ = PreferencesRepository.sharedManager.get(key: "tipoCliente") {
//            tipoCliente = PreferencesRepository.sharedManager.get(key: "tipoCliente") as! String
//        } else {
//            tipoCliente = "PADRAO"
//        }
        
//        if (tipoCliente == "TOTVS") {
//            self.navigationController?.navigationBar.barTintColor = SupplierFlavors.greyTotvs
//            self.separatorView.backgroundColor = SupplierFlavors.blueTotvs
//            self.actionButton.backgroundColor = SupplierFlavors.blueTotvs
//            self.messageContent.tintColor = SupplierFlavors.greyTotvs
//            nameError = "totvs_ic_error"
//            nameSuccess = "totvs_ic_success"
//            self.titleLabel.textColor = SupplierFlavors.greyTotvs
//        } else {
            self.actionButton.layer.cornerRadius = 4.0
            self.messageContent.tintColor = SupplierFlavors.primaryColor
            nameError = "ic_error"
            nameSuccess = "ic_success"
//        }
        
        switch self.bannerType {
        case Banner.positive:
            self.iconImage.isHidden = false
            self.iconImage.image = UIImage.init(named: nameSuccess)
            break
        case Banner.negative:
            self.iconImage.isHidden = false
            self.iconImage.image = UIImage.init(named: nameError)
            break
        default:
            self.iconImage.isHidden = true
            break
        }
        
        self.titleLabel.text = self.customTitle
        self.messageContent.text = self.message
        
        self.actionButton.setTitle(self.caption, for: .normal)
    }
    
    private func setupOverlay() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.close(_:)))
        
        view.addGestureRecognizer(dismissGesture)
    }
    
    @objc private func close(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }

    @IBAction func actionTouched(_ sender: Any) {
        self.dismiss(animated: true)
        if nil != self.actionCallback {
            self.actionCallback!()
        }
    }
    
}
