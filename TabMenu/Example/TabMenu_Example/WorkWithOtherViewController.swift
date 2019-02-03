//
//  SecondViewController.swift
//  TabMenuExample
//
//  Created by kukushi on 21/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit
import SwiftBaseBootstrap
import PureLayout
import TabMenu

class WorkWithOtherViewController: BaseViewControllerWithAutolayout {

    // 初始化逻辑
    override open var accessibilityIdentifier: String {
        return "WorkWithOtherViewController"
    }

    override func setupAndComposeView() {
        self.title = "WorkWithOtherViewController"

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: .plain,  target: self, action: #selector(menuButtonTapped))
        
        let title = UILabel().autoLayout("title")
        title.text = "Working with Pan to Pop"
        title.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(title)

        let pushButton = UIButton().autoLayout("pushButton")
        pushButton.setTitle("Push a view Controller", for: .normal)
        pushButton.addTarget(self, action: #selector(pushButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(pushButton)

        let sliderTitle = UILabel().autoLayout("sliderTitle")
        sliderTitle.text = "Slider"
        sliderTitle.textColor = themeManager.theme.mainSubtitleTextColor
        self.view.addSubview(sliderTitle)

        let slider = UISlider().autoLayout("slider")
        slider.setValue(0.5, animated: false)
        self.view.addSubview(slider)

        title.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        title.autoPinEdge(toSuperviewSafeArea: .left, withInset: 20)
        pushButton.autoPinEdge(.top, to: .bottom, of: title, withOffset: 20)
        pushButton.autoPinEdge(.left, to: .left, of: title)
        sliderTitle.autoPinEdge(.top, to: .bottom, of: pushButton, withOffset: 30)
        sliderTitle.autoPinEdge(.left, to: .left, of: title)
        slider.autoPinEdge(.top, to: .bottom, of: sliderTitle, withOffset: 20)
        slider.autoPinEdge(.left, to: .left, of: title)
        slider.autoPinEdge(toSuperviewSafeArea: .right, withInset: 20)
        slider.autoSetDimension(.height, toSize: 29)
    }

    @objc func menuButtonTapped(_ sender: Any) {
        self.sideMenuController?.openMenu()
    }
    
    @objc func pushButtonTapped(_ sender: Any) {
        let viewController = PushedViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return themeManager.theme.statusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

class PushedViewController: BaseViewControllerWithAutolayout {
    private lazy var tableView: UITableView = {
        let tableView = UITableView().autoLayout("tableView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlainCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = themeManager.theme.mainBackgroundColor
        return tableView
    }()

    // 初始化逻辑
    override open var accessibilityIdentifier: String {
        return "WorkWithOtherViewController"
    }

    override func setupAndComposeView() {
        self.title = "PushedViewController"

        [tableView].forEach {
            self.view.addSubview($0)
        }
        tableView.autoPinEdgesToSuperviewSafeArea()
    }

    var items = [String](repeating: "Cell", count: 100)
}

extension PushedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row]) \(indexPath.row)"

        cell.contentView.backgroundColor = themeManager.theme.mainBackgroundColor
        cell.textLabel?.textColor = themeManager.theme.mainSubtitleTextColor
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

