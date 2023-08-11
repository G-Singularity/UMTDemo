//
//  FrameMacro.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import UIKit

// MARK: - 尺寸信息
/// 屏幕宽度
let kScreenWidth = UIScreen.main.bounds.width
/// 屏幕高度
let kScreenHeight = UIScreen.main.bounds.height

/// 状态栏高度。非刘海屏20，X是44，11是48，12之后是47
let kStatusBarHeight = kSTATUSBAR_HEIGHT()
let kTopSafeHeight = kSTATUSBAR_HEIGHT()
let kBottomSafeHeight = kINDICATOR_HEIGHT()

/// 导航条高度
let kContentNavBarHeight = 44.0
let kNavHeight = (kStatusBarHeight + kContentNavBarHeight)
let kTabBarHeight = (49.0 + kBottomSafeHeight)
let kTabBarButtonHeight = 48.0

/// tableView Y
let kTableViewY = kNavHeight
/// tableView高度
let kTableViewHeight = kScreenHeight-kTableViewY-kBottomSafeHeight

/// tableViewFrame
let kTableViewFrame = CGRect(x: 0, y: kTableViewY, width: kScreenWidth, height: kTableViewHeight)

/// 状态栏高度。X是44，其他是20
func kSTATUSBAR_HEIGHT() ->CGFloat {
    if #available(iOS 13.0, *) {
        return kGetWindow()?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

/// 底部指示条高度
func kINDICATOR_HEIGHT() ->CGFloat {
    if #available(iOS 11.0, *) {
        return kGetWindow()?.safeAreaInsets.bottom ?? 0
    } else {
        return 0
    }
}

/// 获取当前设备window用于判断尺寸
func kGetWindow() -> UIWindow? {
    if #available(iOS 13.0, *) {
        let winScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return winScene?.windows.first
    } else {
        return UIApplication.shared.keyWindow
    }
}
