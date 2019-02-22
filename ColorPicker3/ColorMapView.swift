//
//  ColorMapView.swift
//  ColorPicker3
//
//  Created by Hayashi Ryota on 2019/02/16.
//  Copyright © 2019 Hayashi Ryota. All rights reserved.
//

import UIKit
import CoreFoundation

class ColorMapView: UIView {
    
    // set()にする
    private var brightness: CGFloat = 1
    
    private let colorMap = CALayer()
    
    private static func createColorMapImage(size: CGSize) -> CGImage? {
        let width = Int(size.width)
        let height = Int(size.height)
        let bufferSize: Int = width * height * 3
        let bitmapData: CFMutableData = CFDataCreateMutable(nil, 0)
        CFDataSetLength(bitmapData, CFIndex(bufferSize))
        let bitmap = CFDataGetMutableBytePtr(bitmapData)
        let uint8Max = CGFloat(UInt8.max)
        for y in stride(from: CGFloat(0), to: size.height, by: 1) {
            let saturation = 1 - (y / size.height)
            for x in stride(from: CGFloat(0), to: size.width, by: 1) {
                let hue = x / size.width
                
                let color = UIColor(hue: hue, saturation: saturation, brightness: 1, alpha: 1)
                var r: CGFloat = 0; var g: CGFloat = 0; var b: CGFloat = 0
                color.getRed(&r, green: &g, blue: &b, alpha: nil)
                
                let offset = (Int(x) + (Int(y) * width)) * 3
                bitmap?[offset] = UInt8(r * uint8Max)
                bitmap?[offset + 1] = UInt8(g * uint8Max)
                bitmap?[offset + 2] = UInt8(b * uint8Max)
            }
        }
        
        let colorSpace: CGColorSpace? = CGColorSpaceCreateDeviceRGB()
        let dataProvider: CGDataProvider? = CGDataProvider(data: bitmapData)
        return CGImage(width: width, height: height,
                       bitsPerComponent: 8, bitsPerPixel: 24, bytesPerRow: width * 3,
                       space: colorSpace!, bitmapInfo: [], provider: dataProvider!,
                       decode: nil, shouldInterpolate: false, intent: .defaultIntent)
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
        layer.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(colorMap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorMap.frame = bounds
        colorMap.contents = ColorMapView.createColorMapImage(size: bounds.size)
    }
    
    func set(brightness: CGFloat) {
        self.brightness = brightness
        CATransaction.begin()
        CATransaction.disableActions()
        colorMap.opacity = Float(brightness)
        CATransaction.commit()
    }

    func color(at point: CGPoint) -> HSVColor {
        return HSVColor(hue: point.x/bounds.width,
                        saturation: 1 - (point.y/bounds.height),
                        brightness: brightness)
    }
    
    func position(for color: HSVColor) -> CGPoint {
        return CGPoint(x: color.hue * bounds.width, y: (1 - color.saturation) * bounds.height)
    }
}
