//
//  CustomMessageViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class SingleMessageViewController: UIViewController {
    
    var actionCallback: (() -> Void)?
    
    var message: String?
    var caption: String?
    
    var bannerType: CustomMessageViewController.Banner = CustomMessageViewController.Banner.clear
    
    // Outlets
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
        
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupComponents()
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
//            nameError = "totvs_ic_error"
//            nameSuccess = "totvs_ic_success"
//            self.titleLabel.textColor = SupplierFlavors.greyTotvs
//        } else {
            self.separatorView.backgroundColor = SupplierFlavors.blueTotvs
            self.actionButton.backgroundColor = SupplierFlavors.blueTotvs
            nameError = "ic_error"
            nameSuccess = "ic_success"
//        }
        
        switch self.bannerType {
        case CustomMessageViewController.Banner.positive:
            self.iconImage.isHidden = false
            self.iconImage.image = UIImage.init(named: nameSuccess)
            break
        case CustomMessageViewController.Banner.negative:
            self.iconImage.isHidden = false
            self.iconImage.image = UIImage.init(named: nameError)
            break
        default:
            self.iconImage.isHidden = true
            break
        }
        
        self.titleLabel.text = self.message
        self.actionButton.setTitle(self.caption, for: .normal)
        
    }
    
    private func setupOverlay() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    @IBAction func actionTouched(_ sender: Any) {
        if nil != self.actionCallback {
            self.actionCallback!()
        }
        self.dismiss(animated: true)
    }
    
}
