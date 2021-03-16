//
//  HelpViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    var helpMessage: String = ""
    var tipoCliente: String = ""
    // Outlets
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var helpContent: UITextView!
    
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = PreferencesRepository.sharedManager.get(key: "tipoCliente") {
            tipoCliente = PreferencesRepository.sharedManager.get(key: "tipoCliente") as! String
        } else {
            tipoCliente = "PADRAO"
        }

        self.setupComponents()
        
    }
    
    private func setupComponents() {
        self.setupOverlay()
        
        self.helpContent.text = self.helpMessage
        
        self.mainView.layer.cornerRadius = 4.0
        self.closeButton.layer.cornerRadius = 4.0
        self.closeButton.setTitle("Voltar", for: .normal)
        self.separatorView.backgroundColor = SupplierFlavors.blueTotvs
        self.closeButton.backgroundColor = SupplierFlavors.blueTotvs
    }
    
    private func setupOverlay() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    @IBAction func closeTouched(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
