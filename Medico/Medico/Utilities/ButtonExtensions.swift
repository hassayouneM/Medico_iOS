//
//  ButtonExtensions.swift
//  Medico
//
//  Created by Mac-Mini-2021 on 15/05/2022.
//

import UIKit

extension UIButton {

    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
            
            let flash = CABasicAnimation(keyPath: "opacity")
            flash.duration = 0.5
            flash.fromValue = 1
            flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            flash.autoreverses = true
            flash.repeatCount = 3
            
            layer.add(flash, forKey: nil)
        }
        
      
        func shake() {
            
            let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.1
            shake.repeatCount = 2
            shake.autoreverses = true
            
            let fromPoint = CGPoint(x: center.x - 5, y: center.y)
            let fromValue = NSValue(cgPoint: fromPoint)
            
            let toPoint = CGPoint(x: center.x + 5, y: center.y)
            let toValue = NSValue(cgPoint: toPoint)
            
            shake.fromValue = fromValue
            shake.toValue = toValue
            
            layer.add(shake, forKey: "position")
        }
}
