//
//  OptionMessageViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 22/03/19.
//  Copyright © 2019 Resource. All rights reserved.
//

import UIKit

class OptionMessageViewController: UIViewController {
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cancelCallback: (() -> Void)?
    var continueCallback: (() -> Void)?
    
    var sendCancel: Bool = false
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var errorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var tipoCliente = "";
//
//        if let _ = PreferencesRepository.sharedManager.get(key: "tipoCliente") {
//            tipoCliente = PreferencesRepository.sharedManager.get(key: "tipoCliente") as! String
//        } else {
//            tipoCliente = "PADRAO"
//        }
        
//        if (tipoCliente == "TOTVS") {
//            self.titleLabel.textColor = SupplierFlavors.greyTotvs
//            self.instructionsLabel.textColor = SupplierFlavors.greyTotvs
//            self.separatorView.backgroundColor = SupplierFlavors.blueTotvs
//            self.tryButton.backgroundColor = SupplierFlavors.blueTotvs
//            self.cancelButton.backgroundColor = SupplierFlavors.greyTotvs
//            self.errorImageView.image = UIImage(named: "totvs_ic_error")
//
//        } else {
            self.separatorView.backgroundColor = SupplierFlavors.blueTotvs
            self.tryButton.backgroundColor = SupplierFlavors.blueTotvs
//        }
        
        self.setupOverlay()
    }

    private func setupOverlay() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
     
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.close(_:)))
        
        view.addGestureRecognizer(dismissGesture)
    }
    
    @objc private func close(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func touchCancel(_ sender: Any) {
        self.sendCancel = true
        self.dismiss(animated: false)
    }
    
    @IBAction func touchTryAgain(_ sender: Any) {
        if nil != self.continueCallback {
            self.continueCallback!()
        }
        self.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if nil != self.cancelCallback && self.sendCancel {
            self.cancelCallback!()
        }
    }
    
}
