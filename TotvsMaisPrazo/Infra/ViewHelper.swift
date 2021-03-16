//
//  ViewHelper.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/10/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class ViewHelper: NSObject {

}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
}

extension UIView {
    
    // Keyboard treatment
    
    public func bindToKeyboard(targetView: UIView) {
        
        NotificationCenter.default.addObserver(targetView, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(targetView, selector: #selector(keyboardWasShown), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(targetView, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func removeBindToKeyboard(targetView: UIView) {
        
        NotificationCenter.default.removeObserver(targetView, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(targetView, name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(targetView, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc public func keyboardWasShown(notification: NSNotification) {
        
        let info: NSDictionary = notification.userInfo! as NSDictionary
        
        let duration: Double = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        let curve: Int = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int
        
        let targetFrame: CGRect = info.object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! CGRect
        
        let textFromNotification: UIView? = self.superview?.getFirstResponder()
        
        if textFromNotification == nil {
            return
        }
        
        var targetPoint: CGPoint = (self.window?.rootViewController?.view.convert(textFromNotification!.frame.origin, from: textFromNotification!.superview))!
        
        targetPoint.y += (textFromNotification?.frame.size.height)! + 25
        
        let parentScroll = textFromNotification?.getParentScrollView()
        
        if parentScroll != nil {
            
            var rectToScroll: CGRect = targetFrame
            
            rectToScroll.origin.y = 0
            rectToScroll.size.height = (self.window?.frame.size.height)! - targetFrame.size.height
            parentScroll?.frame = rectToScroll
            
            UIView.animateKeyframes(withDuration: duration, delay: 1, options: UIView.KeyframeAnimationOptions(rawValue: UIView.KeyframeAnimationOptions.RawValue(curve)), animations: {
                
                parentScroll?.frame = rectToScroll
                
            }, completion: nil)
            
            if textFromNotification is UITextView {
                
                let rectTextView: CGRect = (parentScroll?.convert((textFromNotification?.frame)!, from: textFromNotification))!
                
                parentScroll?.scrollRectToVisible(rectTextView, animated: true)
                
            }
            
        } else {
            
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIView.KeyframeAnimationOptions(rawValue: UIView.KeyframeAnimationOptions.RawValue(curve)), animations: {
                
                let newDeltaY: CGFloat = targetPoint.y - (self.window?.frame.size.height)! - targetFrame.size.height
                
                self.window?.frame = CGRect.init(x: (self.window?.frame.origin.x)!,
                                                 y: -newDeltaY > 0 ? 0 : -newDeltaY,
                                                 width: (self.window?.frame.width)!,
                                                 height: (self.window?.frame.height)!)
                
            }, completion: nil)
            
        }
        
    }
    
    @objc public func keyboardWillBeHidden(notification: NSNotification) {
        
        let newFrame = self.window?.bounds
        
        self.frame = newFrame!
        
    }
    
    public func getParentScrollView() -> UIScrollView? {
        
        let scroll: UIView? = self.superview
        
        if (scroll == nil) {
            return nil
        } else {
            
            if scroll is UIScrollView {
                return (scroll as! UIScrollView)
            } else {
                return scroll?.getParentScrollView()
            }
            
        }
        
    }
    
    public func getFirstResponder() -> UIView? {
        
        if self.isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            
            let firstResponder = view.getFirstResponder()
            
            if firstResponder != nil {
                return firstResponder
            }
            
        }
        
        return nil
        
    }
    
    public func textToolbarWithNavigation(navigationOn: Bool) -> UIToolbar {
        
        let bar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 40))
        
        var items = Array<UIBarButtonItem>()
        
        if navigationOn {
            
            let previousButton = UIBarButtonItem.init(title: "<", style: .plain, target: self, action: #selector(previousTextField))
            items.append(previousButton)
            
            let nextButton = UIBarButtonItem.init(title: ">", style: .plain, target: self, action: #selector(nextTextField))
            items.append(nextButton)
        }
        
        let firstButton = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        items.append(firstButton)
        
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(endEditing(_:)))
        items.append(doneButton)
        
        bar.items = items
        
        return bar
        
    }
    
    static var textFieldsInView: Array<UITextField> = Array()
    
    @objc private func nextTextField() {
        
        let currentTextField = self.superview?.getFirstResponder() as! UITextField
        
        if UIView.textFieldsInView.count > 0 {
            
            let index = UIView.textFieldsInView.index(of: currentTextField)
            
            if index! < UIView.textFieldsInView.count - 1 {
                let nextTextField: UITextField = UIView.textFieldsInView[index! + 1]
                nextTextField.becomeFirstResponder()
            } else {
                self.endEditing(true)
            }
        }
        
    }
    
    @objc private func previousTextField() {
        
        let currentTextField = self.superview?.getFirstResponder() as! UITextField
        
        if UIView.textFieldsInView.count > 0 {
            
            let index = UIView.textFieldsInView.index(of: currentTextField)
            
            if index! > 0 {
                let nextTextField: UITextField = UIView.textFieldsInView[index! - 1]
                nextTextField.becomeFirstResponder()
            } else {
                self.endEditing(true)
            }
        }
    }
    
}
