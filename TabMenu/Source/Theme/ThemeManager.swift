//
//  UIPaddedLabel.swift
//  PhotoSaver
//
//  Created by dragonetail on 2018/12/16.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

import UIKit
import Foundation

extension UIColor {
    func hex (_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

public struct Theme {
    public var barStyle: UIBarStyle //Customizing the Navigation Bar
    public var navigationBackgroundImage: UIImage?
    public var tabBarBackgroundImage: UIImage?
    public var statusBarStyle: UIStatusBarStyle

    public var mainBackgroundColor: UIColor
    public var mainTitleTextColor: UIColor
    public var mainSubtitleTextColor: UIColor
    public var secondaryBackgroundColor: UIColor
    public var secondaryTitleTextColor: UIColor
    public var secondarySubtitleTextColor: UIColor

    public static func dark() -> Theme {
        let white: UIColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1.00)
        return Theme(
            barStyle: .black,
            navigationBackgroundImage: nil,
            tabBarBackgroundImage: nil,
            statusBarStyle: .lightContent,
            mainBackgroundColor: UIColor(red: 0.08, green: 0.11, blue: 0.19, alpha: 1.00), //mirage
            mainTitleTextColor: white,
            mainSubtitleTextColor: UIColor(red: 0.75, green: 0.78, blue: 0.81, alpha: 1.00), //lobolly
            secondaryBackgroundColor: UIColor(red: 0.03, green: 0.04, blue: 0.07, alpha: 1.00),
            secondaryTitleTextColor: white,
            secondarySubtitleTextColor: white)
    }

    public static func light() -> Theme {
        let black: UIColor = UIColor().hex("000000")
        let white: UIColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1.00)
        return Theme(
            barStyle: .default,
            navigationBackgroundImage: UIImage(named: "navBackground"),
            tabBarBackgroundImage: UIImage(named: "tabBarBackground"),
            statusBarStyle: .default,
            mainBackgroundColor: white,
            mainTitleTextColor: black,
            mainSubtitleTextColor: black,
            secondaryBackgroundColor: white,
            secondaryTitleTextColor: black,
            secondarySubtitleTextColor: black)
    }
}

//全局变量
public let themeManager: ThemeManager = ThemeManager.shared

open class ThemeManager {
    public static var shared: ThemeManager = ThemeManager()
    private let SelectedThemeKey = "SelectedTheme"

    open var themes: [String: Theme] = [String: Theme]()

    open var themeName: String
    open var theme: Theme

    private init() {
        self.themeName = "light"
        self.theme = Theme.light()

        register("dark", Theme.dark())
        register("light", Theme.light())

        active()
    }

    open func register(_ themeName: String, _ theme: Theme) {
        themes[themeName] = theme
    }

    open func defaultActive() {
        //noop, just active the lazy global variable `themeManager`
    }

    open func active() {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).stringValue {
            active(storedTheme)
        } else {
            return active("light")
        }
    }

    open func active(_ themeName: String) {
        UserDefaults.standard.setValue(themeName, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()

        self.themeName = themeName
        if let theme = themes[themeName] {
            self.theme = theme
            applyTheme(theme)
        } else {
            self.theme = Theme.light()
            applyTheme(self.theme)
        }
    }

    private func applyTheme(_ theme: Theme) {
        let sharedApplication = UIApplication.shared

        sharedApplication.delegate?.window??.tintColor = theme.mainSubtitleTextColor

        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = theme.mainSubtitleTextColor
        UINavigationBar.appearance().barTintColor = theme.mainBackgroundColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: theme.mainTitleTextColor
        ]

        UITabBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage

        let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
        let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
        UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator

        let controlBackground = UIImage(named: "controlBackground")?.withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
            .withRenderingMode(.alwaysTemplate)
            .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))

        UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
        UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected, barMetrics: .default)

        UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
        UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
        UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)

//        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
//        UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
//            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), for: .normal)
//        UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
//            .withRenderingMode(.alwaysTemplate)
//            .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), for: .normal)

        UISwitch.appearance().onTintColor = theme.mainSubtitleTextColor.withAlphaComponent(0.3)
        UISwitch.appearance().thumbTintColor = theme.mainSubtitleTextColor

        UIButton.appearance().tintColor = theme.mainSubtitleTextColor
        UIButton.appearance().setTitleColor(theme.mainSubtitleTextColor, for: .normal)
        UIButton.appearance().backgroundColor = theme.mainBackgroundColor.withAlphaComponent(0.3)
    }
}
