//
//  ActivationDoneViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class ActivationDoneViewController: CommonViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupComponents()
    }

    private func setupComponents() {
        
        self.setupDefaultToolbar()
        
        self.mainLabel.text = "Ativação realizada com sucesso!"
        self.mainLabel.tintColor = SupplierFlavors.blueTotvs
        
//        self.separatorView.backgroundColor = SupplierFlavors.blueTotvs
        
//        self.instructionsLabel.text = "Ativação realizada com sucesso!"
//        self.instructionsLabel.tintColor = SupplierFlavors.greyTotvs
        
        self.actionButton.setTitle("Finalizar", for: .normal)
        self.actionButton.layer.cornerRadius = 4.0
        self.actionButton.backgroundColor = SupplierFlavors.blueTotvs
    }

    @IBAction func actionTouched(_ sender: Any) {
        self.navigateToHome()
    }
    
    private func navigateToHome() {
        
        let user = User()
        user.name = "Manoel"
        user.cpf = "000.000.000-00"
        
        let homeController = HomeViewController()
        homeController.user = user
        
        let navController = UINavigationController.init(rootViewController: homeController)
        self.navigationController?.present(navController, animated: true)
    }
    
}
