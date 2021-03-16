//
//  CircularProgressBar.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 08/11/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

protocol CircularProgressBarDelegate {
    func notifyEnded()
}

class CircularProgressBar: UIView {
    
    var delegate: CircularProgressBarDelegate?
    
    private var label = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
            else { return (self.frame.height - lineWidth)/2 }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        label.text = "0"
    }
    
    //MARK: Public
    
    public var lineWidth:CGFloat = 50 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    public var labelSize: CGFloat = 20 {
        didSet {
            label.font = UIFont.systemFont(ofSize: labelSize)
            label.sizeToFit()
            configLabel()
        }
    }
    
    public var safePercent: Int = 100 {
        didSet{
            setForegroundLayerColorForSafePercent()
        }
    }
    
    public func setProgress(currentProgress: Double, totalTimeSeconds: Double) {
        
        let timeInterval = totalTimeSeconds / 100
        
        foregroundLayer.strokeEnd = CGFloat(1)
        
        var currentTime = currentProgress * timeInterval
        
        let from = currentTime / 100
        
        let timeLeft = totalTimeSeconds - currentTime
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = from
        animation.toValue = 1
        animation.duration = timeLeft
        foregroundLayer.add(animation, forKey: "foregroundAnimation")
        
        NSLog("STARTED: %@", NSDate())
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            
            if currentTime >= totalTimeSeconds {
                NSLog("FINISH: %@", NSDate())
                timer.invalidate()
                if nil != self.delegate {
                    self.delegate?.notifyEnded()
                }
            } else {
                currentTime += timeInterval
            }
        }
        timer.fire()
        
    }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    
    private func makeBar(){
        
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
    }
    
    private func drawForegroundLayer(){
        
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        
//        var tipoCliente = "";
//
//        if let _ = PreferencesRepository.sharedManager.get(key: "tipoCliente") {
//            tipoCliente = PreferencesRepository.sharedManager.get(key: "tipoCliente") as! String
//        } else {
//            tipoCliente = "PADRAO"
//        }
//
        foregroundLayer.strokeColor = SupplierFlavors.greenTotvs.cgColor
        
        foregroundLayer.strokeEnd = 0
        
        self.layer.addSublayer(foregroundLayer)
        
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.font = UIFont.systemFont(ofSize: labelSize)
        label.sizeToFit()
        label.center = pathCenter
        return label
    }
    
    private func configLabel(){
        label.sizeToFit()
        label.center = pathCenter
    }
    
    private func setForegroundLayerColorForSafePercent(){
        if Int(label.text!)! >= self.safePercent {
            self.foregroundLayer.strokeColor = UIColor.green.cgColor
        } else {
//            var tipoCliente = "";
//            
//            if let _ = PreferencesRepository.sharedManager.get(key: "tipoCliente") {
//                tipoCliente = PreferencesRepository.sharedManager.get(key: "tipoCliente") as! String
//            } else {
//                tipoCliente = "PADRAO"
//            }
            
            foregroundLayer.strokeColor = SupplierFlavors.greenTotvs.cgColor
        }
    }
    
    private func setupView() {
        makeBar()
        self.addSubview(label)
    }
    
    //Layout Sublayers
    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            let tempText = label.text
            setupView()
            label.text = tempText
            layoutDone = true
        }
    }

}
