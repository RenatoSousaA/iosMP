//
//  HomeViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 04/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class HomeViewController: CommonViewController {
    
    var user: User?
    
    var storedMessage: String = ""
    
    // Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var cpfLabel: UILabel!
    
    @IBOutlet weak var scannerArea: UIView!
    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var scannerImage: UIView!
    @IBOutlet weak var scannerLabel: UIView!
    
    @IBOutlet weak var tokenArea: UIView!
    @IBOutlet weak var tokenView: UIView!
    @IBOutlet weak var tokenImage: UIView!
    @IBOutlet weak var tokenLabel: UIView!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.versionLabel.text = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        
        self.setupComponents()
        
        self.getDeviceIdByAPI()
        
    }
    
    private func setupComponents() {
        
        self.setupDefaultToolbar()
        
        self.userLabel.tintColor = SupplierFlavors.primaryColorMedium
        self.cpfLabel.tintColor = SupplierFlavors.primaryColorMedium
        
//        self.scannerView.backgroundColor = SupplierFlavors.blueTotvs
        self.scannerView.backgroundColor = UIColor.white
        self.scannerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.scannerView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.scannerView.layer.shadowOpacity = 0.6
        self.scannerView.layer.shadowRadius = 2.0
        self.scannerView.layer.masksToBounds = false
        self.scannerView.layer.cornerRadius = 4.0
        
//        self.tokenView.backgroundColor = SupplierFlavors.blueTotvs
        self.tokenView.backgroundColor = UIColor.white
        self.tokenView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.tokenView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.tokenView.layer.shadowOpacity = 0.6
        self.tokenView.layer.shadowRadius = 2.0
        self.tokenView.layer.masksToBounds = false
        self.tokenView.layer.cornerRadius = 4.0
        
        self.setupGestures()
    }
    
    private func setupGestures() {
        
        self.setCardStatus(view: self.scannerView, isEnabled: true)
        self.setCardStatus(view: self.tokenView, isEnabled: true)
    }
    
    private func setCardStatus(view: UIView, isEnabled: Bool) {
        
        if isEnabled {
            
            if view == scannerView {
                let scannerGesture = UITapGestureRecognizer.init(target: self, action: #selector(scannerTouched))
                view.addGestureRecognizer(scannerGesture)
            }
            if view == tokenView {
                let tokenGesture = UITapGestureRecognizer.init(target: self, action: #selector(tokenTouched))
                view.addGestureRecognizer(tokenGesture)
            }
        }
        else
        {
            view.backgroundColor = UIColor.lightGray
            view.gestureRecognizers?.removeAll()
        }
    }
    
    private func getDeviceIdByAPI() {
        
        let fingerPrint = SecurityRepository.sharedManager.getDeviceId()

        let defaultTitleError = "Ops!"
        let defaultErrorMessage = AppDelegate.readingErrorMessage
        
        self.showLoading()
        
        SecurityRepository.sharedManager.getDeviceIdByFingerPrint(fingerPrint: fingerPrint!, completion: { (result) in
                    
        if let deviceIdAPI = result["deviceIdAPI"] as? String {
            PreferencesRepository.sharedManager.save(key: "deviceIdAPI", item: "\(deviceIdAPI)")
            self.loadUserInfo(deviceIdAPI: deviceIdAPI)
        }
            
        }) { (error) in
            if (error.contains("Internet connection")) {
                self.dismissLoading()
                self.showCustomMessage(title: defaultTitleError, message: defaultErrorMessage, caption: "Ok", bannerType: .negative)
                self.setCardStatus(view: self.scannerView, isEnabled: false)
            } else {
                self.showCustomMessage(title: defaultTitleError, message: "Este celular não está ativo para utilização do TOTVS Mais Prazo", caption: "Fechar", bannerType: .negative, action: {
                    
                    exit(0)
                    
                })
            }
        }
        
    }
    
    private func loadUserInfo(deviceIdAPI: String) {
        
        let tokenCode = SecurityRepository.sharedManager.getTokenValue()
//        let deviceId = SecurityRepository.sharedManager.getDeviceId()
        
        let deviceId = deviceIdAPI

        if (tokenCode == nil || deviceId == nil) {
            self.navigateToActivate()
        } else {
            let defaultTitleError = "Ops!"
            let defaultErrorMessage = AppDelegate.readingErrorMessage
            
            self.showLoading()
            
            SecurityRepository.sharedManager.getUserInformation(deviceId: deviceId, tokenCode: tokenCode!, completion: { (result) in
                
                self.dismissLoading()
                
                if let status = result["status"] as? String {
                    
                    switch status {
                    case "001":
                        self.fillUser(entry: result)
                        self.fillHelp(entry: result)
                        break
                    case "056":
                        self.showCustomMessage(title: defaultTitleError, message: "Este celular não está ativo para utilização do TOTVS Mais Prazo", caption: "Fechar", bannerType: .negative, action: {
                            
                            exit(0)
                            
                        })
                        break
                    default:
                        break
                    }
                    
                } else {
                    self.showCustomMessage(title: defaultTitleError, message: defaultErrorMessage, caption: "Ok", bannerType: .negative)
                    self.setCardStatus(view: self.scannerView, isEnabled: false)
                }
                
            }) { (error) in
                
                self.dismissLoading()
                
                self.showCustomMessage(title: defaultTitleError, message: defaultErrorMessage, caption: "Ok", bannerType: .negative)
                self.setCardStatus(view: self.scannerView, isEnabled: false)
            }
        }
        
        
    }
    
    private func fillUser(entry: NSDictionary) {
        
        if let user = entry["user"] as? User {
            self.user = user
            self.showUserInfo()
            
            userLabel.textColor = SupplierFlavors.greyTotvs
            cpfLabel.textColor = SupplierFlavors.greyTotvs
            
//            tokenView.backgroundColor = SupplierFlavors.blueTotvs
//            scannerView.backgroundColor = SupplierFlavors.blueTotvs
            
            versionView.backgroundColor = SupplierFlavors.blueTotvs
            versionLabel.textColor = SupplierFlavors.blueTotvs
            
            self.navigationController?.navigationBar.barTintColor = SupplierFlavors.navBarColor
            
            let logoImage = UIImage.init(named: "totvs_maisprazo")
            let logoView = UIImageView.init(image: logoImage)
            let logoButton = UIBarButtonItem.init(customView: logoView)
            
            self.navigationController?.navigationBar.topItem?.leftBarButtonItem = logoButton
            
            PreferencesRepository.sharedManager.save(key: "tipoCliente", item: "TOTVS")
            
        }
    }
    
    private func fillHelp(entry: NSDictionary) {
        
//        if let helpMessage = entry["help"] as? String {
//            AppDelegate.helpText = helpMessage
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        self.setOrientation(orientation: UIInterfaceOrientation.portrait)
    }
    
    private func showUserInfo() {
        
        self.userLabel.isHidden = false
        self.cpfLabel.isHidden = false
        self.scannerView.isHidden = false
        self.tokenView.isHidden = false
        self.versionView.isHidden = false
        self.versionLabel.isHidden = false
        
        if let name = user?.name {
            self.userLabel.text = String.init(format: "Oi, %@", name)
            self.userLabel.isHidden = false
        }
        
        if let cpf = user?.cpf {
            self.cpfLabel.text = String.init(format: "CPF: %@", cpf)
            self.cpfLabel.isHidden = false
        }
        
    }
    
    @objc private func scannerTouched() {
        // Verificar horário do último Token e comparar com 30min para pedir a leitura do QR Code novamente
        self.navigateToScanner()
    }
    
    @objc private func tokenTouched() {
        self.navigateToToken()
    }
    
    private func navigateToToken() {
        
        let navController = UINavigationController.init(rootViewController: TokenViewController())
        self.navigationController?.present(navController, animated: true)
    }
    
    private func navigateToActivate() {
        let navController = UINavigationController.init(rootViewController: ActivationViewController())
        self.navigationController?.present(navController, animated: true)
    }
    
    private func navigateToScanner() {
        
        let barcodeCallback: ((String?) -> ()) = { (code) in
            
            if let result = code {
                
                if result.elementsEqual("") {
                    DispatchQueue.main.async {
                        self.showCodeError(title: "Leitura não realizada", message: "Tivemos dificuldade em ler o código de barras ou ele está incorreto.", caption: "Tentar novamente", action: {
                            
                            DispatchQueue.main.async {
                                self.navigateToScanner()
                            }
                        })
                    }
                    return
                }
                
                let paymentQRCode = SecurityDomain.sharedManager.retrievePaymentQRCode()
                
                if nil == paymentQRCode {
                    DispatchQueue.main.async {
                        self.navigateToQRCode(barcode: code!)
                    }
                    
                } else {
                    // Possui o QR Code
                    self.sendBarcode(paymentBarCode: code!, paymentQRCode: paymentQRCode!, showMessage: false, successful: {
                        
                        self.showReadingDoneMessage()
                        
                    }, failure: { (error) in
                        
                        DispatchQueue.main.async {
                            self.showCodeError(title: "QRCode não validado", message: error, caption: "Ok")
                        }
                    })
                }
                
            }
            
            
        }
        
        let scanController = ScannerViewController()
        scanController.resultAcquiredCallback = barcodeCallback
        
        let navController = UINavigationController.init(rootViewController: scanController)
        self.present(navController, animated: true)
    }
    
    private func showErrorMessage() {
        
        if !self.storedMessage.elementsEqual("") {
            
            let action = {
                self.navigateToScanner()
            }
            
            DispatchQueue.main.async {
                self.showCodeError(title: "QRCode não validado", message: self.storedMessage, caption: "Tentar novamente", action: action)
                self.storedMessage = ""
            }
        }
    }
    
    private func showReadingDoneMessage() {
        
        let title = "Leitura Ok!"
        let message = "Volte ao Portal TOTVS Mais Prazo para\ncontinuar com o pagamento do boleto."
        
        self.showCustomMessage(title: title, message: message, caption: "Finalizar", bannerType: .positive)
    }
    
    private func sendBarcode(paymentBarCode: String, paymentQRCode: String, showMessage: Bool, successful: @escaping () -> Void, failure: @escaping (String) -> Void) {
        
        let token = SecurityRepository.sharedManager.getTokenValue()
        
        SecurityRepository.sharedManager.saveBarCode(barcode: paymentBarCode, token: token!, qrCode: paymentQRCode, completion: { (result) in
            
            if result { successful() }
            
            failure("")
            
        }) { (apiError, error) in
            
            var messageError = error
            
            if apiError {
                messageError = error
            } else {
                messageError = "Ocorreu algum problema. Tente novamente."
                if error.contains("Internet") && error.contains("offline") {
                    messageError = "Ocorreu um problema de conexão. Verifique seu acesso à internet e tente novamente."
                }
            }
            
            failure(messageError)
            NSLog(error)
            
        }
        
    }
    
    private func navigateToQRCode(barcode: String) {
        
        let qrCodeCallback: ((String?) -> ()) = { (code) in
            
            let action = {
                
                DispatchQueue.main.async {
                    self.navigateToScanner()
                }
            }
            
            if nil != code {
                SecurityDomain.sharedManager.savePaymentQRCode(code: code!)
                self.sendBarcode(paymentBarCode: barcode, paymentQRCode: code!, showMessage: true, successful: {
                    
                    self.showReadingDoneMessage()
                    
                }, failure: { (error) in
                    
                    DispatchQueue.main.async {
                        self.showCodeError(title: "Ops!", message: error, caption: "Ok", action: action)
                    }
                })
            } else {
                
                if self.storedMessage.elementsEqual("") {
                    self.storedMessage = "Ocorreu algum problema."
                }
                
                DispatchQueue.main.async {
                    self.showCodeError(title: "QR Code não validado", message: self.storedMessage, caption: "Voltar", action: action)
                }
            }
        }
        
        let scanController = QRScanViewController()
        scanController.resultAcquiredCallback = qrCodeCallback
        scanController.loadMessage = true
        scanController.customTitle = "Leitor de código de barras"
        scanController.descriptionMessage = "Posicione abaixo o QRCode exibido no Portal TOTVS Mais Prazo."
        
        let navController = UINavigationController.init(rootViewController: scanController)
        
        self.present(navController, animated: true)
    }
    
}


