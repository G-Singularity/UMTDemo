//
//  NSStringExt.swift
//  ArsenalSwift
//
//  Created by dqh on 4/7/22.
//

import Foundation

extension NSString {
    
    /// 判空
    public var isEmpty: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
    
    /// 一串字符在固定宽度下，正常显示所需要的高度
    func getStringHeight(_ width: CGFloat, _ font: CGFloat) -> CGFloat {
        let size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return size.height
    }
    
    /// 一串字符在一行中正常显示所需要的宽度
    func getStringWidth(_ font: CGFloat) -> CGFloat {
        let size = self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return size.width
    }
    
    /// 字符串转换为类
    ///
    /// - Parameter className: 类名字符串
    /// - Returns: 类对象
    class func classFromString(_ className: String) -> UIViewController! {
        /// 获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        /// 根据命名空间传来的字符串先转换成anyClass
        let cls: AnyClass = NSClassFromString(namespace + "." + className)!;
        // 在这里已经可以return了   返回类型:AnyClass!
        //return cls;
        /// 转换成 明确的类
        let vcClass = cls as! UIViewController.Type;
        /// 返回这个类的对象
        return vcClass.init();
    }
    

    class func cellClassFromString(_ className: String) -> UICollectionViewCell! {
        /// 获取命名空间
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        /// 根据命名空间传来的字符串先转换成anyClass
        let cls: AnyClass = NSClassFromString(namespace + "." + className)!;
        // 在这里已经可以return了   返回类型:AnyClass!
        //return cls;
        /// 转换成 明确的类
        let vcClass = cls as! UICollectionViewCell.Type;
        /// 返回这个类的对象
        return vcClass.init();
    }

    
}
