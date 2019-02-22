//
//  HRColorPicker.swift
//  ColorPicker3
//
//  Created by Hayashi Ryota on 2019/02/16.
//  Copyright © 2019 Hayashi Ryota. All rights reserved.
//

import UIKit

class HRColorPicker: UIControl {
    private let colorMap = ColorMapView()
    private let colorMapCursor = HRColorCursor()
    private let brightnessSlider = HRBrightnessSlider()
    private let brightnessCursor = HRColorCursor()
    
    var color: UIColor = UIColor.darkGray {
        didSet {
            mapColorToView(color: color)
        }
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
        addSubview(colorMap)
        addSubview(colorMapCursor)
        addSubview(brightnessSlider)
        addSubview(brightnessCursor)
        
        // TODO タップも対応する
        let colorMapPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleColorMapPan(pan:)))
        colorMap.addGestureRecognizer(colorMapPan)
        
        let brightnessPan = UIPanGestureRecognizer(target: self, action: #selector(self.handleBrightnessPan(pan:)))
        brightnessSlider.addGestureRecognizer(brightnessPan)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorMap.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 44)
        brightnessSlider.frame = CGRect(x: 0, y: bounds.height - 44, width: bounds.width, height: 44)
        mapColorToView(color: color)
    }
    
    private func mapColorToView(color: UIColor) {
        let hsv = HSVColor(color: color)
        colorMap.set(brightness: hsv.brightness)
        colorMapCursor.center =  colorMap.convert(colorMap.position(for: hsv), to: self)
        colorMapCursor.set(color: color)
        brightnessSlider.set(hue: hsv.hue, saturation: hsv.saturation)
        brightnessCursor.center = CGPoint(x: brightnessSlider.position(for: hsv), y: brightnessSlider.frame.midY)
        brightnessCursor.set(color: color)
    }
    
    @objc
    func handleColorMapPan(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            colorMapCursor.startEditing()
        case .cancelled, .ended, .failed:
            colorMapCursor.endEditing()
        default:
            break
        }
        let selectedColor = colorMap.color(at: pan.location(in: colorMap))
        mapColorToView(color: selectedColor.uiColor)
    }
    
    @objc
    func handleBrightnessPan(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            brightnessCursor.startEditing()
        case .cancelled, .ended, .failed:
            brightnessCursor.endEditing()
        default:
            break
        }
        let selectedColor = brightnessSlider.color(at: pan.location(in: colorMap).x)
        mapColorToView(color: selectedColor.uiColor)
    }
}
