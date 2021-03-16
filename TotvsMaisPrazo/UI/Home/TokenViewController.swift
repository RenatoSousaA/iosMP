//
//  TokenViewController.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 24/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

import didm_auth_sdk_iOS

class TokenViewController: CommonViewController {
    
    var tokenLayer: CAShapeLayer?
    var tipoCliente: String = ""
    var timer: Timer?
    
    // Outlets
    
    @IBOutlet weak var progressBar: CircularProgressBar!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var refLabel: UILabel!
    
    @IBOutlet weak var tokenImage: UIImageView!
    
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
        
        self.setupToolbarWithBackButton(showHelp: false, title: "Token")
        
        self.titleLabel.textColor = SupplierFlavors.greyTotvs
        self.tokenLabel.textColor = SupplierFlavors.greenTotvs
        self.refLabel.textColor = SupplierFlavors.greyTotvs
        
        self.titleLabel.text = "Código Token"
        
        self.getTokenValue()
        
        self.refLabel.text = String.init(format: "Ref.: %@", self.getTokenId())
        
        self.setupTokenRing()
        
        self.checkTime(animated: false)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.checkTime(animated: true)
        })
    }
    
    private func setupTokenRing() {
        
        let start = self.degreesToRadians(number: 270)
        let end = self.degreesToRadians(number: 630)
        
            let center = CGPoint(x: tokenImage.frame.width / 2, y: tokenImage.frame.height / 2)
        
        let bezier = UIBezierPath()
        bezier.addArc(withCenter: center, radius: 75, startAngle: start, endAngle: end, clockwise: true)
        
        self.tokenLayer = CAShapeLayer()
        self.tokenLayer?.path = bezier.cgPath
        
        self.tokenLayer?.strokeColor = SupplierFlavors.greenTotvs.cgColor
        
        self.tokenLayer?.fillColor = UIColor.clear.cgColor
        self.tokenLayer?.lineWidth = 10
        //        layer.strokeEnd = 1
        self.tokenLayer?.strokeEnd = 0.95
        
        self.tokenImage.layer.addSublayer(self.tokenLayer!)
    }
    
    private func degreesToRadians(number: Double) -> CGFloat {
        
        return CGFloat(number * .pi / 180)
    }
    
    private func checkTime(animated: Bool) {
        
        if let currentProgress = self.getTokenProgress() {
            
            var currentValue = currentProgress
            var shouldAnimate = true
            
            if currentProgress == 0 {
                self.getTokenValue()
                currentValue = 1
                shouldAnimate = false
            }
            
            print("Current: \(currentValue)")
            self.setArcProgress(value: currentValue, animated: shouldAnimate)
        }
    }
    
    private func getCurrentAccount() -> Account? {
        
        guard let accounts = AppDelegate.tokenInstance?.getAccounts(), let currentAccount = accounts.first as? Account else {
            NSLog("Error getting Token Accounts")
            self.timer?.invalidate()
            return nil
        }
        
        return currentAccount
    }
    
    private func getTokenProgress() -> Int32? {
        
        if let current = self.getCurrentAccount() {
            return AppDelegate.tokenInstance?.otp_API.getTokenTimeStepValue(current)
        }
        
        return nil
    }
    
    private func getTokenId() -> String {
        
        guard let deviceId = AppDelegate.tokenInstance?.getDeviceID() else {
            NSLog("Error getting Token ID")
            return "error"
        }
        
        let deviceIdAPI = PreferencesRepository.sharedManager.get(key: "deviceIdAPI") as? String

        let ref = deviceIdAPI!.customSubstring(from: deviceIdAPI!.count - 6, count: 6)
//        let index = deviceIdAPI.index(deviceIdAPI.startIndex, offsetBy: 5)
//        let mySubstring = deviceIdAPI[..<index]

        return ref
    }
    
    private func getTokenValue() {
        
        if let current = self.getCurrentAccount() {
            
            let tokenValue = AppDelegate.tokenInstance?.otp_API.getTokenValue(current)
            
            self.tokenLabel.text = tokenValue
        }
    }
    
    private func setArcProgress(value: Int32, animated: Bool) {
        
        let real = CGFloat(value) / 100
        
        if animated {
            
            UIView.animate(withDuration: 0) {
                self.tokenLayer?.strokeEnd = real
            }
            
        } else {
            
            self.tokenLayer?.strokeEnd = real
        }
        
    }
    
}
