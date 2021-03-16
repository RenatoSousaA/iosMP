//
//  QRScanViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 08/11/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

import MTBBarcodeScanner

class QRScanViewController: CommonViewController {
    
    var loadMessage: Bool = false
    
    var descriptionMessage: String?
    
    var scanner: MTBBarcodeScanner?
    
    var customTitle: String?
    
    var resultAcquiredCallback: ((String?) -> ())?
    
    var timer: Timer?
    var readingInterval: TimeInterval = TimeInterval.init(15)
    
    var waitBeforeScanner: Bool = false
    
    // Outlets
    @IBOutlet weak var previewView: UIView!
    
    @IBOutlet weak var instructionsView: UIView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var targetImageView: UIImageView!
    
    @IBOutlet weak var overlayView1: UIView!
    @IBOutlet weak var overlayView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setOrientation(orientation: .portrait)
        
        self.setupToolbarWithBackButton(showHelp: false)
        
        let title = self.customTitle ?? "QR Code"
        
        self.setupToolbarTitle(title: title)

        self.setupMessage()
        
//        var tipoCliente = "";
//        
//        if let _ = PreferencesRepository.sharedManager.get(key: "tipoCliente") {
//            tipoCliente = PreferencesRepository.sharedManager.get(key: "tipoCliente") as! String
//        } else {
//            tipoCliente = "PADRAO"
//        }
//        
//        if (tipoCliente == "TOTVS") {
//            targetImageView.image = UIImage(named: "totvs_mask_codebar")
//            self.navigationController?.navigationBar.barTintColor = SupplierFlavors.greyTotvs
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startScanner), userInfo: nil, repeats: false)
    }
    
    private func setupMessage() {
        if self.loadMessage {
            self.instructionsLabel.text = self.descriptionMessage
        }
    }
    
    private func setupScanner() {
        
        self.targetView.backgroundColor = UIColor.clear
        
        self.overlayView1.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.overlayView2.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let origin = self.previewView.frame.origin
        
        let height = self.view.frame.height - self.instructionsView.frame.height
        
        let size = CGSize.init(width: self.previewView.frame.width, height: height)
        
        self.previewView.frame = CGRect.init(origin: origin, size: size)
        
        if nil == self.scanner {
            self.scanner = MTBBarcodeScanner.init(previewView: self.previewView)
        }
    }
    
    @objc private func startScanner() {
        
        self.setupScanner()
        
        MTBBarcodeScanner.requestCameraPermission { (success) in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { (codes) in
                        if let codes = codes {
                            for code in codes {
                                if code.stringValue != nil {
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
        
        if nil != resultAcquiredCallback {
            resultAcquiredCallback!(code)
        }
                
        self.close()
        
    }
    
    private func close() {
        self.dismiss(animated: true)
    }
    
    private func startTimer() {
        
        if self.timer == nil {
            timer = Timer.scheduledTimer(timeInterval: readingInterval, target: self, selector: #selector(readingIntervalElapsed), userInfo: nil, repeats: false)
        }
    }
    
    @objc func readingIntervalElapsed() {
        NSLog("Hit it")
        self.timer = nil
    }

}
