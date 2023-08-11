//
//  ColorFontMacro.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import Foundation

func UIColorFromRGB(rgbValue:Int) -> UIColor {
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000)>>16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: 1.0)
}

func UIColorFromRGB(rgbValue:Int, alpha: CGFloat) -> UIColor {
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000)>>16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: alpha)
}
