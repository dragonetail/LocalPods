//
//  File.swift
//  TabMenu
//
//  Created by dragonetail on 2019/1/29.
//  Copyright © 2019 dragonetail. All rights reserved.
//

import UIKit
import SwiftBaseBootstrap
import PureLayout
import TabMenu

class OtherExampleViewController: BaseViewControllerWithAutolayout {
    
    // 初始化逻辑
    override open var accessibilityIdentifier: String {
        return "OtherExampleViewController"
    }
    
    override func setupAndComposeView() {
        self.view.autoLayout(accessibilityIdentifier)
        self.title = "Example"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: .plain,  target: self, action: #selector(menuButtonTapped))
        
        let reloadButton = UIButton().autoLayout("reloadButton")
        reloadButton.setTitle("Push a view Controller", for: .normal)
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(reloadButton)
        
        reloadButton.autoCenterInSuperview()
    }
    
    @objc func menuButtonTapped(_ sender: Any) {
        self.sideMenuController?.openMenu()
    }
    
    @objc func reloadButtonTapped(_ sender: Any) {
        var themeName = "dark"
        if themeManager.themeName == "dark" {
            themeName = "light"
        }
        themeManager.active(themeName)
        
        UIApplication.shared.keyWindow?.backgroundColor = themeManager.theme.mainBackgroundColor
        
        let sideMenuController = TabMenuController()
        sideMenuController.configs.tabMenuWidth = 240
        sideMenuController.configs.statusBarBehavior = .none
        sideMenuController.configs.position = .above
        sideMenuController.configs.direction = .left
        sideMenuController.configs.enablePanGesture = true
        sideMenuController.configs.supportedOrientations = .portrait
        sideMenuController.configs.shouldRespectLanguageDirection = true
        
        sideMenuController.contentViewController = TabMenuNavigationController.wrapper(PreferencesViewController()) 
        sideMenuController.menuViewController = LeftTabMenuViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themeManager.theme.statusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
