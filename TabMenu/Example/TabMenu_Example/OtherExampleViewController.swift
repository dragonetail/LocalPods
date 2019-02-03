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
        self.tabMenuController?.openMenu()
    }
    
    @objc func reloadButtonTapped(_ sender: Any) {
        var themeName = "dark"
        if themeManager.themeName == "dark" {
            themeName = "light"
        }
        themeManager.active(themeName)
        
        UIApplication.shared.keyWindow?.backgroundColor = themeManager.theme.mainBackgroundColor
        
        let tabMenuController = TabMenuController()
        tabMenuController.configs.tabMenuWidth = 240
        tabMenuController.configs.statusBarBehavior = .none
        tabMenuController.configs.position = .above
        tabMenuController.configs.direction = .left
        tabMenuController.configs.enablePanGesture = true
        tabMenuController.configs.supportedOrientations = .portrait
        tabMenuController.configs.shouldRespectLanguageDirection = true
        
        tabMenuController.contentViewController = TabMenuNavigationController.wrapper(PreferencesViewController()) 
        tabMenuController.menuViewController = LeftTabMenuViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = tabMenuController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themeManager.theme.statusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}
