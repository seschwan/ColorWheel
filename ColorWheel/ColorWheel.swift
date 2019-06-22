//
//  ColorWheel.swift
//  ColorWheel
//
//  Created by Corey Sessions on 6/20/19.
//  Copyright © 2019 Corey Sessions. All rights reserved.
//

import UIKit

class ColorWheel: UIControl {

    var color: UIColor = .white
    
    private func color(for location: CGPoint) -> UIColor {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let dy = location.y - center.y
        let dx = location.x - center.x
        let offset = CGPoint(x: dx / center.x, y: dy / center.y)
        let (hue, saturation) = Color.getHueSaturation(at: offset)
        
        let color = UIColor(hue: hue, saturation: saturation, brightness: 0.9, alpha: 1.0)
        //print(color.rgba)
        
        return color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        let raduis = frame.width / 2
        self.layer.cornerRadius = raduis
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        for y in stride(from: 0, through: bounds.maxY, by: 1) {
            for x in stride(from: 0, through: bounds.maxX, by: 1) {
                let color = self.color(for: CGPoint(x: x, y: y))
                let pixel = CGRect(x: x, y: y, width: 1, height: 1)
                
                color.set()
                
                UIRectFill(pixel)
            }
        }
        
    }
    
    
    
    
    // MARK: -
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("Beginning Tracking")
        let touchPoint = touch.location(in: self)
        self.color = self.color(for: touchPoint)
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }

    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("Continue Tracking")
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            self.color = self.color(for: touchPoint)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
            print("Touch drag Outside")
        }
        return  true
    }
    
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event)}
        print("Ending Tracking")
        
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            self.color = self.color(for: touchPoint)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
            print("TOuch UP Outside")
        }
    }

    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
        print("Cancel Tracking")
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
