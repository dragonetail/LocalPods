//
//  ViewController.swift
//  TabMenu
//
//  Created by dragonetail on 2018/12/20.
//  Copyright © 2018 dragonetail. All rights reserved.
//
import UIKit
import SwiftBaseBootstrap
import PureLayout
import TabMenu

class PreferencesViewController: BaseViewControllerWithAutolayout {
    let Configs: TabMenuController.Configs.Type = TabMenuController.Configs.self
    var configs: TabMenuController.Configs!

    // 初始化逻辑
    override open var accessibilityIdentifier: String {
        return "PreferencesViewController"
    }

    override func setupAndComposeView() {
        guard let configs = self.sideMenuController?.configs else {
            fatalError("没有找到sideMenuController。")
        }
        self.configs = configs

        self.title = "配置选项"

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: .plain, target: self, action: #selector(menuButtonTapped))

        var previos: UIView = statusBarBehavior()
        previos = panGesture(previos)
        previos = rubberEffect(previos)
        previos = menuDirection(previos)
        previos = menuPosition(previos)
        previos = transitionAnimation(previos)
        previos = theme(previos)
        previos = stepper(previos)
        previos = slider(previos)
    }

    fileprivate func statusBarBehavior() -> UIView {
        let statusBarBehaviorTitle = UILabel().autoLayout("statusBarBehaviorTitle")
        statusBarBehaviorTitle.text = "状态栏"
        statusBarBehaviorTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(statusBarBehaviorTitle)

        let statusBarBehaviorControl = UISegmentedControl(items: Configs.StatusBarBehavior.allCases.map({ "\($0)" })).autoLayout("statusBarBehaviorControl")
        statusBarBehaviorControl.selectedSegmentIndex = Configs.StatusBarBehavior.allCases.firstIndex(of: configs.statusBarBehavior) ?? 0
        self.view.addSubview(statusBarBehaviorControl)
        statusBarBehaviorControl.addTarget(self, action: #selector(changeStatusBarBehavior(_:)), for: .valueChanged)

        statusBarBehaviorTitle.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        statusBarBehaviorTitle.autoPinEdge(toSuperviewSafeArea: .left, withInset: 20)
        statusBarBehaviorControl.autoPinEdge(.top, to: .bottom, of: statusBarBehaviorTitle, withOffset: 10)
        statusBarBehaviorControl.autoPinEdge(.left, to: .left, of: statusBarBehaviorTitle)
        statusBarBehaviorControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        statusBarBehaviorControl.autoSetDimension(.height, toSize: 29)

        return statusBarBehaviorControl
    }
    @objc func changeStatusBarBehavior(_ sender: UISegmentedControl) {
        let statusBarBehavior = Configs.StatusBarBehavior.allCases[sender.selectedSegmentIndex]
        configs.statusBarBehavior = statusBarBehavior
    }

    fileprivate func menuDirection(_ previos: UIView) -> UIView {
        let menuDirectionTitle = UILabel().autoLayout("menuDirectionTitle")
        menuDirectionTitle.text = "菜单方向"
        menuDirectionTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(menuDirectionTitle)

        let menuDirectionControl = UISegmentedControl(items: Configs.MenuDirection.allCases.map({ "\($0)" })).autoLayout("menuDirectionControl")
        menuDirectionControl.selectedSegmentIndex = Configs.MenuDirection.allCases.firstIndex(of: configs.direction) ?? 0
        self.view.addSubview(menuDirectionControl)
        menuDirectionControl.addTarget(self, action: #selector(changeMenuDirection(_:)), for: .valueChanged)

        menuDirectionTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        menuDirectionTitle.autoPinEdge(.left, to: .left, of: previos)
        menuDirectionControl.autoPinEdge(.top, to: .bottom, of: menuDirectionTitle, withOffset: 10)
        menuDirectionControl.autoPinEdge(.left, to: .left, of: menuDirectionTitle)
        menuDirectionControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        menuDirectionControl.autoSetDimension(.height, toSize: 29)

        return menuDirectionControl
    }
    @objc func changeMenuDirection(_ sender: UISegmentedControl) {
        let direction = Configs.MenuDirection.allCases[sender.selectedSegmentIndex]
        configs.direction = direction
    }

    fileprivate func menuPosition(_ previos: UIView) -> UIView {
        let menuPositionTitle = UILabel().autoLayout("menuPositionTitle")
        menuPositionTitle.text = "菜单空间位置"
        menuPositionTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(menuPositionTitle)

        let menuPositionControl = UISegmentedControl(items: Configs.MenuPosition.allCases.map({ "\($0)" })).autoLayout("menuPositionControl")
        menuPositionControl.selectedSegmentIndex = Configs.MenuPosition.allCases.firstIndex(of: configs.position) ?? 0
        self.view.addSubview(menuPositionControl)
        menuPositionControl.addTarget(self, action: #selector(changeMenuPositionControl(_:)), for: .valueChanged)

        menuPositionTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        menuPositionTitle.autoPinEdge(.left, to: .left, of: previos)
        menuPositionControl.autoPinEdge(.top, to: .bottom, of: menuPositionTitle, withOffset: 10)
        menuPositionControl.autoPinEdge(.left, to: .left, of: menuPositionTitle)
        menuPositionControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        menuPositionControl.autoSetDimension(.height, toSize: 29)

        return menuPositionControl
    }
    @objc func changeMenuPositionControl(_ sender: UISegmentedControl) {
        let menuPosition = Configs.MenuPosition.allCases[sender.selectedSegmentIndex]
        configs.position = menuPosition
    }

    fileprivate func theme(_ previos: UIView) -> UIView {
        let themeTitle = UILabel().autoLayout("themeTitle")
        themeTitle.text = "颜色主题"
        themeTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(themeTitle)

        let themes = themeManager.themes.map { $0.key }
        let themeControl = UISegmentedControl(items: themes).autoLayout("themeControl")
        themeControl.selectedSegmentIndex = themes.firstIndex(of: themeManager.themeName) ?? 0
        self.view.addSubview(themeControl)
        themeControl.addTarget(self, action: #selector(changeTheme(_:)), for: .valueChanged)


        themeTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        themeTitle.autoPinEdge(.left, to: .left, of: previos)
        themeControl.autoPinEdge(.top, to: .bottom, of: themeTitle, withOffset: 10)
        themeControl.autoPinEdge(.left, to: .left, of: themeTitle)
        themeControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        themeControl.autoSetDimension(.height, toSize: 29)

        return themeControl
    }
    @objc func changeTheme(_ sender: UISegmentedControl) {
        let themes = themeManager.themes.map { $0.key }
        let themeName = themes[sender.selectedSegmentIndex]
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


    fileprivate func panGesture(_ previos: UIView) -> UIView {
        let panGestureTitle = UILabel().autoLayout("panGestureTitle")
        panGestureTitle.text = "手势拖动"
        panGestureTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(panGestureTitle)

        let panGestureControl = UISwitch().autoLayout("panGestureControl")
        panGestureControl.setOn(self.sideMenuController?.configs.enablePanGesture ?? true, animated: false)
        self.view.addSubview(panGestureControl)
        panGestureControl.addTarget(self, action: #selector(changeEnablePanGesture(_:)), for: .valueChanged)

        panGestureTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        panGestureTitle.autoPinEdge(.left, to: .left, of: previos)
        panGestureControl.autoPinEdge(.left, to: .right, of: panGestureTitle, withOffset: 10)
        panGestureControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        panGestureControl.autoAlignAxis(.horizontal, toSameAxisOf: panGestureTitle)
        panGestureControl.autoSetDimension(.height, toSize: 29)

        return panGestureTitle
    }
    @objc func changeEnablePanGesture(_ sender: UISwitch) {
        self.sideMenuController?.configs.enablePanGesture = sender.isOn
    }

    fileprivate func rubberEffect(_ previos: UIView) -> UIView {
        let rubberEffectTitle = UILabel().autoLayout("rubberEffectTitle")
        rubberEffectTitle.text = "Rubber动画效果"
        rubberEffectTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(rubberEffectTitle)

        let rubberEffectControl = UISwitch().autoLayout("rubberEffectControl")
        rubberEffectControl.setOn(self.sideMenuController?.configs.enableRubberEffectWhenPanning ?? true, animated: false)
        self.view.addSubview(rubberEffectControl)
        rubberEffectControl.addTarget(self, action: #selector(changeEnableRubberEffectWhenPanning(_:)), for: .valueChanged)

        rubberEffectTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        rubberEffectTitle.autoPinEdge(.left, to: .left, of: previos)
        rubberEffectControl.autoPinEdge(.left, to: .right, of: rubberEffectTitle, withOffset: 10)
        rubberEffectControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        rubberEffectControl.autoAlignAxis(.horizontal, toSameAxisOf: rubberEffectTitle)
        rubberEffectControl.autoSetDimension(.height, toSize: 29)

        return rubberEffectTitle
    }
    @objc func changeEnableRubberEffectWhenPanning(_ sender: UISwitch) {
        self.sideMenuController?.configs.enableRubberEffectWhenPanning = sender.isOn
    }

    fileprivate func transitionAnimation(_ previos: UIView) -> UIView {
        let transitionAnimationTitle = UILabel().autoLayout("transitionAnimationTitle")
        transitionAnimationTitle.text = "变换动画"
        transitionAnimationTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(transitionAnimationTitle)

        let transitionAnimationControl = UISwitch().autoLayout("transitionAnimationControl")
        transitionAnimationControl.setOn(self.sideMenuController?.configs.enableTransitionAnimation ?? true, animated: false)
        self.view.addSubview(transitionAnimationControl)
        transitionAnimationControl.addTarget(self, action: #selector(changeEnableTransitionAnimation(_:)), for: .valueChanged)

        transitionAnimationTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        transitionAnimationTitle.autoPinEdge(.left, to: .left, of: previos)
        transitionAnimationControl.autoPinEdge(.left, to: .right, of: transitionAnimationTitle, withOffset: 10)
        transitionAnimationControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        transitionAnimationControl.autoAlignAxis(.horizontal, toSameAxisOf: transitionAnimationTitle)
        transitionAnimationControl.autoSetDimension(.height, toSize: 29)

        return transitionAnimationTitle
    }
    @objc func changeEnableTransitionAnimation(_ sender: UISwitch) {
        self.sideMenuController?.configs.enableTransitionAnimation = sender.isOn
    }

    fileprivate func stepper(_ previos: UIView) -> UIView {
        let stepperTitle = UILabel().autoLayout("stepper")
        stepperTitle.text = "步长控件"
        stepperTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(stepperTitle)

        let stepperControl = UIStepper().autoLayout("stepperControl")
        stepperControl.value = 0.5
        self.view.addSubview(stepperControl)

        stepperTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        stepperTitle.autoPinEdge(.left, to: .left, of: previos)
        stepperControl.autoPinEdge(.left, to: .right, of: stepperTitle, withOffset: 10)
        stepperControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        stepperControl.autoAlignAxis(.horizontal, toSameAxisOf: stepperTitle)
        stepperControl.autoSetDimension(.height, toSize: 29)

        return stepperTitle
    }
    fileprivate func slider(_ previos: UIView) -> UIView {
        let sliderTitle = UILabel().autoLayout("sliderTitle")
        sliderTitle.text = "Slider测试"
        sliderTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(sliderTitle)

        let sliderControl = UISlider().autoLayout("sliderControl")
        sliderControl.value = 0.5
        self.view.addSubview(sliderControl)

        sliderTitle.autoPinEdge(.top, to: .bottom, of: previos, withOffset: 20)
        sliderTitle.autoPinEdge(.left, to: .left, of: previos)
        sliderControl.autoPinEdge(.top, to: .bottom, of: sliderTitle, withOffset: 10)
        sliderControl.autoPinEdge(.left, to: .left, of: sliderTitle)
        sliderControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        sliderControl.autoSetDimension(.height, toSize: 29)

        return sliderControl
    }

    @objc func menuButtonTapped(_ sender: Any) {
        self.sideMenuController?.openMenu()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themeManager.theme.statusBarStyle
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
