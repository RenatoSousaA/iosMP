//
//  ActivationViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 19/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

import didm_auth_sdk_iOS

class ActivationViewController: CommonViewController {
    
    var defaultTextFieldLayer: CALayer?
    
    var barCodeFlag: Bool = false
    
    // Outlets
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var activationCodeLabel: UILabel!
    @IBOutlet weak var activationCodeTextField: UITextField!
    
    @IBOutlet weak var codeInstructionsLabel: UILabel!
    
    @IBOutlet weak var scannerButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkActivation()

        setupComponents()
    }
    
    private func setupComponents() {
        
        self.setupDefaultToolbar()
        
        self.defaultTextFieldLayer = CALayer.init(layer: self.activationCodeTextField.layer)
        
        self.mainLabel.text = "Ativação do aplicativo"
        self.mainLabel.textColor = SupplierFlavors.blueTotvs
        
        self.instructionsLabel.text = "Digite o código de ativação que você recebeu no e-mail de boas-vindas"
        self.instructionsLabel.textColor = SupplierFlavors.greyTotvs
        
        self.separatorView.backgroundColor = SupplierFlavors.blueTotvs
        
        self.activationCodeLabel.text = "Código de ativação"
        self.activationCodeLabel.textColor = SupplierFlavors.greyTotvs
        
        
        self.codeInstructionsLabel.text = "Se preferir, ative o aplicativo por meio do QRCode"
        self.codeInstructionsLabel.numberOfLines = 3
        self.codeInstructionsLabel.textColor = SupplierFlavors.greyTotvs
        
        self.scannerButton.tintColor = SupplierFlavors.primaryColor
        self.scannerButton.setTitle("Ler QRCode", for: .normal)
        self.scannerButton.layer.cornerRadius = 4.0
        self.scannerButton.layer.borderColor = SupplierFlavors.primaryColor.cgColor
        self.scannerButton.layer.borderWidth = 1
        
        self.continueButton.isEnabled = false
        self.continueButton.tintColor = UIColor.lightGray
        self.continueButton.backgroundColor = UIColor.lightGray
        self.continueButton.setTitleColor(UIColor.white, for: .normal)
        self.continueButton.setTitle("Continuar", for: .normal)
        self.continueButton.layer.cornerRadius = 4.0
        
        self.setupKeyboard()
        
//        self.showCrashButton()
    }
    
    private func checkActivation() {
        if SecurityDomain.sharedManager.isActivated() {
            self.navigateToHome()
        }
    }
    
    private func setupKeyboard() {
        
        self.view.bindToKeyboard(targetView: self.mainView)
        
        self.activationCodeTextField.addTarget(self, action: #selector(ActivationViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.activationCodeTextField.inputAccessoryView = self.view.textToolbarWithNavigation(navigationOn: true)
        self.activationCodeTextField.delegate = self
        
    }
    
    @IBAction func continueTouched(_ sender: Any) {
        
//        self.navigateToActivation()
        
        let activationCode = self.activationCodeTextField.text

        if self.validateActivationCode(activationCode: activationCode!) {
            
            self.barCodeFlag = false

            self.activateDetectID(activationCode: activationCode!)
        }
        
    }
    
    private func validateActivationCode(activationCode: String) -> Bool {
        let isValid = !activationCode.elementsEqual("")
        
        if !isValid {
            self.showWarning(label: activationCodeLabel, textField: activationCodeTextField)
        }
        
        return isValid
    }
    
    private func activateDetectID(activationCode: String) {
        
        AppDelegate.tokenInstance?.enableRegistrationServerResponseAlerts(false)
        
        AppDelegate.tokenInstance?.deviceRegistrationServerResponseDelegate = self as DeviceRegistrationServerResponseDelegate
        
        self.showLoading()
        
        AppDelegate.tokenInstance?.deviceRegistration(byCode: activationCode)
        
//        print(AppDelegate.tokenInstance?.getSharedDeviceID())
//        print(AppDelegate.tokenInstance?.getDeviceID())
        
        AppDelegate.tokenInstance?.getDeviceID()
        AppDelegate.tokenInstance?.getSharedDeviceID()
    }
    
    private func filterResult(result: String) -> NSDictionary {
        
        var message = ""
        
        var status = true
        
        switch result {
        case "98":
            message = "Parametro vazio"
            status = false
            break
        case "99":
            message = "Erro no sistema"
            status = false
            break
        case "1002":
            message = "O código de ativação já foi usado"
            status = false
            break
        case "1010":
            message = "Sistema Operacional não suportado"
            status = false
            break
        case "1011":
            message = "Código de ativação não existe"
            status = false
            break
        case "1012":
            message = "O código de ativação expirou"
            status = false
            break
        case "1013":
            message = "O cliente atingiu o número máximo de dispositivos permitidos"
            status = false
            break
        case "1014":
            message = "O dispositivo já está registrado"
            status = false
            break
        default:
            status = true
            break
        }
        
        return [ "message": message,
                 "status": status]
        
    }
    
    @IBAction func readTouched(_ sender: Any) {
        self.navigateToQRCode()
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
    
    private func navigateToActivation() {
        
        let navController = UINavigationController.init(rootViewController: ActivationDoneViewController())
        self.navigationController?.present(navController, animated: true)
    }
    
    private func navigateToQRCode() {
        
        let action = {
            
            self.navigateToQRCode()
        }
        
        let qrCodeCallback: ((String?) -> ()) = { (code) in
            
            guard let readedCode = code else {
                let title = "QRCode não validado"
                let message = "Tivemos dificuldade em ler o QRCode de ativação ou ele está incorreto."
                
                DispatchQueue.main.async {
                    self.showCustomMessage(title: title, message: message, caption: "Tentar novamente", bannerType: .negative, action: action)
                }
                return
            }
            
            self.activateDetectID(activationCode: readedCode)
            
        }
        
        let scanController = QRScanViewController()
        scanController.resultAcquiredCallback = qrCodeCallback
        
        self.barCodeFlag = true
        
        let navController = UINavigationController.init(rootViewController: scanController)
        
        self.present(navController, animated: true)
    }
    
    private func showWarning(label: UILabel, textField: UITextField) {
        
        label.textColor = SupplierFlavors.blueTotvs
        
        textField.textColor = SupplierFlavors.greyTotvs
        
        textField.layer.borderColor = SupplierFlavors.blueTotvs.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
    }
    
    private func clearWarning(label: UILabel, textField: UITextField) {
        
        label.textColor = UIColor.gray
        
        textField.layer.borderWidth = (defaultTextFieldLayer?.borderWidth)!
        textField.layer.borderColor = (defaultTextFieldLayer?.borderColor)!
        textField.layer.cornerRadius = (defaultTextFieldLayer?.cornerRadius)!
    }
    
}

extension ActivationViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (textField.text?.count)! == 8 {
            self.continueButton.isEnabled = true
            self.continueButton.tintColor = UIColor.white
            self.continueButton.setTitleColor(UIColor.white, for: .normal)
            self.continueButton.backgroundColor = SupplierFlavors.primaryColor
        }
        else
        {
            self.continueButton.isEnabled = false
            self.continueButton.tintColor = UIColor.white
            self.continueButton.setTitleColor(UIColor.white, for: .normal)
            self.continueButton.backgroundColor = UIColor.lightGray
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UITextField.init(frame: CGRect.zero).textColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text {
            
            let finalText = currentText.appending(string)
            
            if finalText.count > 8 {
                return false
            }
        }
        return true
    }
    
}

extension ActivationViewController: DeviceRegistrationServerResponseDelegate {
    
    func onRegistrationResponse(_ result: String!) {
                
        let result = self.filterResult(result: result)
        
        self.dismissLoading()
        
        if let status = result["status"] as? Bool {
            
            if status {
                SecurityDomain.sharedManager.notifyActivation()
                self.navigateToActivation()
            } else {
                let title = self.barCodeFlag ? "QRCode não validado" : "Código incorreto"
                let message = self.barCodeFlag ? "QRCode incorreto, por favor tente novamente." : "Código incorreto, por favor tente novamente."
                self.showWarning(label: self.activationCodeLabel, textField: self.activationCodeTextField)
                
                let action: (() -> Void) = {
                    if !self.barCodeFlag {
                        return
                    }
                    DispatchQueue.main.async {
                        self.barCodeFlag = false
                        self.navigateToQRCode()
                    }
                }
                
                DispatchQueue.main.async {
                    self.showCustomMessage(title: title, message: message, caption: "Voltar", bannerType: .negative, action: action)
                }
            }
            
        }
    }
}
