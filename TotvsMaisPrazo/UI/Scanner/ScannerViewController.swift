//
//  ScannerViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 09/11/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

import MTBBarcodeScanner

class ScannerViewController: CommonViewController {
    
    var scanner: MTBBarcodeScanner?
    
    var scannedCode: String = ""
    var isWaitingQRCode = false
    var finishedQR = false
    
    var sendToHomeOnDismiss: Bool = false
    
    var resultAcquiredCallback: ((String?) -> ())?
    
    var timer: Timer?
    var readingInterval: TimeInterval = TimeInterval.init(15)
//    var readingInterval: TimeInterval = TimeInterval.init(3)
    
    // Outlets
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var scanImageView: UIImageView!
    
    @IBOutlet weak var topOverlayView: UIView!
    @IBOutlet weak var bottomOverlayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupToolbarWithBackButton(showHelp: false)
        
        self.setupToolbarTitle(title: "Leitor de código de barras")
        
        self.setupInstructions()
        
//        var tipoCliente = "";
//        
//        if let _ = PreferencesRepository.sharedManager.get(key: "tipoCliente") {
//            tipoCliente = PreferencesRepository.sharedManager.get(key: "tipoCliente") as! String
//        } else {
//            tipoCliente = "PADRAO"
//        }
//        
//        if (tipoCliente == "TOTVS") {
//            scanImageView.image = UIImage(named: "totvs_mask_codebar")
//            self.navigationController?.navigationBar.barTintColor = SupplierFlavors.greyTotvs
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setOrientation(orientation: UIInterfaceOrientation.landscapeRight)
        
        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .landscapeRight
        
        self.setupScanner()
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startScanner), userInfo: nil, repeats: false)
        
    }
    
    private func setupInstructions() {
        
        let boldText  = "código de barras"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText1 = "Posicione o "
        let normalString1 = NSMutableAttributedString(string: normalText1)
        
        let normalText2 = " no centro e aguarde a leitura automática"
        let normalString2 = NSMutableAttributedString(string: normalText2)
        
        normalString1.append(attributedString)
        normalString1.append(normalString2)
        
        self.instructionsLabel.attributedText = normalString1
        
    }
    
    private func setupScanner() {
        
        self.view.backgroundColor = UIColor.clear
        
        self.topOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.bottomOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        if nil == self.scanner {
            self.scanner = MTBBarcodeScanner.init(previewView: self.view)
        }
    }
    
    @objc private func startScanner() {
        
        self.startTimer()
        
        MTBBarcodeScanner.requestCameraPermission { (success) in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { (codes) in
                        if let codes = codes {
                            for code in codes {
                                if code.stringValue != nil && code.stringValue?.count == 44 {
                                    
                                    self.scanner?.stopScanning()
                                    self.getCodeFromScanner(code: code.stringValue!)
                                }
                            }
                        }
                    })
                } catch {
                    NSLog("Camera Error")
                }
            }
        }
    }
    
    private func getCodeFromScanner(code: String) {
        
        NSLog("Scanned: %@", code)
        
        self.scannedCode = code
        
        self.sendPaymentCodeToHome()

        self.close()
    }
    
    private func sendPaymentCodeToHome() {
        if nil != self.resultAcquiredCallback {
            self.resultAcquiredCallback!(self.scannedCode)
        }
    }
    
    private func close() {
        self.dismiss(animated: false)
    }
    
    private func startTimer() {
        
        if self.timer == nil {
            timer = Timer.scheduledTimer(timeInterval: readingInterval, target: self, selector: #selector(readingIntervalElapsed), userInfo: nil, repeats: false)
        }
    }
    
    @objc func readingIntervalElapsed() {
        self.timer = nil
        
        self.showTimedMessage()
    }
    
    private func showTimedMessage() {
        
        let timedController = OptionMessageViewController()
        
        timedController.providesPresentationContextTransitionStyle = true
        timedController.definesPresentationContext = true
        timedController.modalPresentationStyle = .overCurrentContext
        timedController.modalTransitionStyle = .crossDissolve
        
        timedController.cancelCallback = {
            self.close()
        }
        
        timedController.continueCallback = {
            self.startTimer()
        }
        
        self.present(timedController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if sendToHomeOnDismiss {
            self.sendPaymentCodeToHome()
        }
    }
    
}
