//
//  Entity.swift
//  ColorPicker3
//
//  Created by Hayashi Ryota on 2019/02/16.
//  Copyright © 2019 Hayashi Ryota. All rights reserved.
//

import UIKit

struct HSVColor {
    let hue: CGFloat
    let saturation: CGFloat
    let brightness: CGFloat
}

extension HSVColor {
    init(color: UIColor) {
        var h: CGFloat = 0; var s: CGFloat = 0; var b: CGFloat = 0
        color.getHue(&h, saturation: &s, brightness: &b, alpha: nil)
        hue = h
        saturation = s
        brightness = b
    }
    
    var uiColor: UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
