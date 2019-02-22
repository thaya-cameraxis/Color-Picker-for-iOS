//
//  HRColorCursor.swift
//  ColorPicker3
//
//  Created by Hayashi Ryota on 2019/02/16.
//  Copyright © 2019 Hayashi Ryota. All rights reserved.
//

import UIKit

class HRColorCursor: UIView {
    
    private let backgroundLayer = CALayer()
    private let colorLayer = CALayer()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundLayer.borderWidth = 1 / UIScreen.main.scale
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(colorLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let backgroundSize = CGSize(width: 28, height: 28)
        backgroundLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        backgroundLayer.bounds = CGRect(origin: .zero, size: backgroundSize)
        backgroundLayer.cornerRadius = backgroundSize.width/2
        
        let colorSize = CGSize(width: 17, height: 17)
        colorLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        colorLayer.bounds = CGRect(origin: .zero, size: colorSize)
        colorLayer.cornerRadius = colorSize.width/2
    }
    
    func set(color: UIColor) {
        let hsv = HSVColor(color: color)
        
        let grayBackground: Bool = hsv.brightness > 0.7 && hsv.saturation < 0.4
        
        CATransaction.begin()
        CATransaction.disableActions()
        
        colorLayer.backgroundColor = color.cgColor
        if grayBackground {
            backgroundLayer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
            backgroundLayer.backgroundColor = UIColor(white: 0, alpha: 0.2).cgColor
        } else {
            backgroundLayer.borderColor = UIColor(white: 0.65, alpha: 1).cgColor
            backgroundLayer.backgroundColor = UIColor(white: 1, alpha: 0.7).cgColor
        }
        
        CATransaction.commit()
    }
    
    func startEditing() {
        backgroundLayer.transform = CATransform3DMakeScale(1.6, 1.6, 1)
        colorLayer.transform = CATransform3DMakeScale(1.4, 1.4, 1)
    }
    
    func endEditing() {
        backgroundLayer.transform = CATransform3DIdentity
        colorLayer.transform = CATransform3DIdentity
    }
}
