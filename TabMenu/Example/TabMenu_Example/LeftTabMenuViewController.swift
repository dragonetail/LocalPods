//
//  LeftTabMenuViewController.swift
//  PhotoSaver
//
//  Created by dragonetail on 2018/12/20.
//  Copyright © 2018 dragonetail. All rights reserved.
//
import UIKit
import SwiftBaseBootstrap
import PureLayout
import TabMenu

class LeftTabMenuViewController: BaseViewControllerWithAutolayout {

    lazy var selectionTableViewHeader: UILabel = {
        let selectionTableViewHeader = UILabel().autoLayout("selectionTableViewHeader")
        selectionTableViewHeader.text = "菜单"
        selectionTableViewHeader.textColor = themeManager.theme.secondaryTitleTextColor
        return selectionTableViewHeader
    }()

    lazy var menuTableView: UITableView = {
        let menuTableView = UITableView().autoLayout("menuTableView")
        menuTableView.register(SelectionCell.self, forCellReuseIdentifier: "Cell")
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.separatorStyle = .none
        menuTableView.backgroundColor = themeManager.theme.secondaryBackgroundColor
        return menuTableView
    }()

    // 初始化逻辑
    override open var accessibilityIdentifier: String {
        return "LeftTabMenuViewController"
    }

    override func setupAndComposeView() {
        [selectionTableViewHeader, menuTableView].forEach {
            self.view.addSubview($0)
        }
        
        sideMenuController?.cache(viewController: TabMenuNavigationController.wrapper(WorkWithOtherViewController()), with: "1")
        sideMenuController?.cache(viewController: TabMenuNavigationController.wrapper(OtherExampleViewController()), with: "2")
    }

    override func setupConstraints() {
        selectionTableViewHeader.autoAlignAxis(.vertical, toSameAxisOf: self.view)
        selectionTableViewHeader.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        selectionTableViewHeader.autoSetDimension(.height, toSize: 60)
        
        menuTableView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets.zero, excludingEdge: .top)
        menuTableView.autoPinEdge(.top, to: .bottom, of: selectionTableViewHeader, withOffset: 0)
    }
}

extension LeftTabMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectionCell
        let row = indexPath.row
        if row == 0 {
            cell.titleLabel.text = "配置选项"
        } else if row == 1 {
            cell.titleLabel.text = "滚动视图"
        } else if row == 2 {
            cell.titleLabel.text = "代码"
        }
        
        cell.contentView.backgroundColor = themeManager.theme.secondaryBackgroundColor
        cell.titleLabel.textColor = themeManager.theme.secondarySubtitleTextColor
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row

        sideMenuController?.setContentViewController(with: "\(row)", animated: self.sideMenuController?.configs.enableTransitionAnimation ?? true)
        sideMenuController?.hideMenu()
        
        print("[Example] View Controller Cache Identifier: " + sideMenuController!.currentCacheIdentifier()!)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

class SelectionCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel().autoLayout("titleLabel")
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAndComposeView()
        self.setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupAndComposeView() {
        [titleLabel].forEach {
            addSubview($0)
        }
    }

    fileprivate var didSetupConstraints = false
    override func updateConstraints() {
        if (!didSetupConstraints) {
            didSetupConstraints = true
            setupConstraints()
        }
        //modifyConstraints()

        super.updateConstraints()
    }

    // invoked only once
    func setupConstraints() {
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 12.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 5.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5.0)
    }
}

