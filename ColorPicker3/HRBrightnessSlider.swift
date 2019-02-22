//
//  HRBrightnessSlider.swift
//  ColorPicker3
//
//  Created by Hayashi Ryota on 2019/02/16.
//  Copyright © 2019 Hayashi Ryota. All rights reserved.
//

import UIKit

class HRBrightnessSlider: UIView {
    private let gradientLayer = CAGradientLayer()
    
    private lazy var brightest: HSVColor = { preconditionFailure() }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func set(hue: CGFloat, saturation: CGFloat) {
        brightest = HSVColor(hue: hue, saturation: saturation, brightness: 1)
        CATransaction.begin()
        CATransaction.disableActions()
        gradientLayer.colors = [
            brightest.uiColor.cgColor,
            HSVColor(hue: hue, saturation: saturation, brightness: 0).uiColor.cgColor
        ]
        CATransaction.commit()
    }
    
    func color(at point: CGFloat) -> HSVColor {
        return HSVColor(hue: brightest.hue,
                        saturation: brightest.saturation,
                        brightness: 1 - (point / bounds.width))
    }
    
    func position(for color: HSVColor) -> CGFloat {
        return (1 - color.brightness) * bounds.width
    }
}
