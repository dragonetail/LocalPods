//
//  SwiftPopMenu.swift
//  PhotoSaver
//
//  Created by dragonetail on 2019/3/10.
//  Copyright © 2019 dragonetail. All rights reserved.
//

import Foundation
import UIKit

public class SwiftPopMenuConfig {
    //整体位置偏移
    var yMargin: CGFloat = -10
    //箭头大小
    public var arrowViewWidth: CGFloat = 15
    public var arrowViewHeight: CGFloat = 8

    //圆角弧度
    public var cornorRadius: CGFloat = 5

    //菜单项宽度
    var menuItemWidth: CGFloat = 150
    //菜单项高度
    var menuItemHeight: CGFloat = 44

    //菜单项文字颜色
    public var menuItemColor: UIColor = UIColor(red: 107 / 255.0, green: 107 / 255.0, blue: 107 / 255.0, alpha: 1.0)
    //菜单项字体
    public var menuItemFont: UIFont = UIFont.systemFont(ofSize: 16)

    //菜单项分割线颜色
    public var seperateLineBackgroundColor: UIColor = UIColor(red: 222 / 255.0, green: 222 / 255.0, blue: 222 / 255.0, alpha: 0.5)
    //菜单项分割线高度
    public var seperateLineHeight: CGFloat = 1

    //菜单项图标两侧Padding
    public var iconPadding: CGFloat = 12
    //菜单项图标宽度
    public var iconWidth: CGFloat = 24
    //菜单项图标高度
    public var iconHeight: CGFloat = 24
    //菜单文字标题后面Padding
    public var titleEndPadding: CGFloat = 3


    //菜单项背景色
    public var popMenuBackgroundColor: UIColor = UIColor.white
    //内容区遮罩背景
    public var contentBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.2)
}

@objc(PopMenuItem)
public class PopMenuItem: NSObject {
    public var icon: String
    public var title: String
    public var target: Any?
    public var action: Selector?

    public init(icon: String, title: String, target: Any? = nil, action: Selector? = nil) {
        self.icon = icon
        self.title = title
        self.target = target
        self.action = action
    }
}

open class SwiftPopMenu: UIView {
    private static let cellID: String = "SwiftPopMenuCellID"

    public var config: SwiftPopMenuConfig = SwiftPopMenuConfig()

    public var popMenuItems: [PopMenuItem]?

    private var initialized: Bool = false

    /// The absolute source frame relative to screen.
    private(set) var absoluteSourceFrame: CGRect = CGRect.zero

    private lazy var tableViewHeight: CGFloat = {
        guard let popMenuItems = popMenuItems else {
            return 0
        }

        return CGFloat(popMenuItems.count) * config.menuItemHeight
    }()


    private lazy var arrowView: UIView = {
        let arrowViewFrame = CGRect(
            x: absoluteSourceFrame.origin.x + absoluteSourceFrame.size.width / 2 - config.arrowViewWidth / 2,
            y: absoluteSourceFrame.origin.y + absoluteSourceFrame.size.height + config.yMargin,
            width: config.arrowViewWidth,
            height: config.arrowViewHeight)
        let arrowView = UIView(frame: arrowViewFrame)
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: config.arrowViewWidth / 2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: config.arrowViewHeight))
        path.addLine(to: CGPoint(x: config.arrowViewWidth, y: config.arrowViewHeight))
        layer.path = path.cgPath
        layer.fillColor = config.popMenuBackgroundColor.cgColor
        arrowView.layer.addSublayer(layer)

        return arrowView
    }()

    private lazy var tableView: UITableView = {
        var tableViewFrame = CGRect(
            x: absoluteSourceFrame.origin.x,
            y: absoluteSourceFrame.origin.y + absoluteSourceFrame.size.height + config.yMargin + config.arrowViewHeight, //padding
            width: config.menuItemWidth,
            height: tableViewHeight)

        translateOverflowX(desiredOrigin: &tableViewFrame.origin, contentSize: tableViewFrame.size)

        let tableView = UITableView(frame: tableViewFrame, style: .plain)
        tableView.register(SwiftPopMenuCell.classForCoder(), forCellReuseIdentifier: SwiftPopMenu.cellID)
        tableView.backgroundColor = config.popMenuBackgroundColor
        tableView.layer.cornerRadius = config.cornorRadius
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false

        return tableView
    }()

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }

    public func show(_ sourceViewObject: AnyObject? = nil) {
        initViews(sourceViewObject)
        
        self.isHidden = false
    }

    func initViews(_ sourceViewObject: AnyObject? = nil) {
        if (initialized) {
            return
        }
        initialized = true

        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.backgroundColor = config.contentBackgroundColor

        //箭头
        self.addSubview(arrowView)
        self.addSubview(self.tableView)

        let sourceView: UIView? = sourceViewAsUIView(sourceViewObject)
        self.absoluteSourceFrame = computeAbsoluteSourceFrame(sourceView)
        self.setNeedsLayout()

        //        tableView.visibleCells.forEach { (cell) in
        //            cell.setSelected(false, animated: false)
        //        }

        UIApplication.shared.keyWindow?.addSubview(self)
    }

    public func dismiss() {
        self.isHidden = true
    }

    deinit {
        self.removeFromSuperview()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.backgroundColor = config.contentBackgroundColor

        let arrowViewFrame = CGRect(
            x: absoluteSourceFrame.origin.x + absoluteSourceFrame.size.width / 2 - config.arrowViewWidth / 2,
            y: absoluteSourceFrame.origin.y + absoluteSourceFrame.size.height + config.yMargin, //padding
            width: config.arrowViewWidth,
            height: config.arrowViewHeight)

        var tableViewFrame = CGRect(
            x: absoluteSourceFrame.origin.x,
            y: absoluteSourceFrame.origin.y + absoluteSourceFrame.size.height + config.yMargin + config.arrowViewHeight, //padding
            width: config.menuItemWidth,
            height: tableViewHeight)

        translateOverflowX(desiredOrigin: &tableViewFrame.origin, contentSize: tableViewFrame.size)
        arrowView.frame.origin = arrowViewFrame.origin
        tableView.frame.origin = tableViewFrame.origin
    }

    /// Compute absolute source frame relative to screen frame.
    fileprivate func computeAbsoluteSourceFrame(_ sourceViewAsUIView: UIView? = nil) -> CGRect {
        if let sourceView = sourceViewAsUIView {
            return sourceView.convert(sourceView.bounds, to: nil)
        }

        return CGRect(x: self.center.x - config.menuItemWidth / 2,
                      y: self.center.y - tableViewHeight / 2,
                      width: config.menuItemWidth,
                      height: tableViewHeight)
    }

    fileprivate func sourceViewAsUIView(_ sourceView: AnyObject?) -> UIView? {
        guard let sourceView = sourceView else { return nil }

        // Check if UIBarButtonItem
        if let sourceBarButtonItem = sourceView as? UIBarButtonItem {
            if let buttonView = sourceBarButtonItem.value(forKey: "view") as? UIView {
                return buttonView
            }
        }

        if let sourceView = sourceView as? UIView {
            return sourceView
        }

        return nil
    }

    fileprivate func translateOverflowX(desiredOrigin: inout CGPoint, contentSize: CGSize) {
        let edgePadding: CGFloat = 8
        // Check content in left or right side
        let leftSide = (desiredOrigin.x - self.center.x) < 0

        // Check view overflow
        let origin = CGPoint(x: leftSide ? desiredOrigin.x : desiredOrigin.x + contentSize.width, y: desiredOrigin.y)

        // Move accordingly
        if !self.frame.contains(origin) {
            let overflowX: CGFloat = (leftSide ? 1 : -1) * ((leftSide ? self.frame.origin.x : self.frame.origin.x + self.frame.size.width) - origin.x) + edgePadding

            desiredOrigin = CGPoint(x: desiredOrigin.x - (leftSide ? -1 : 1) * overflowX, y: origin.y)
        }
    }

//    fileprivate static func translateOverflowY(desiredOrigin: inout CGPoint, contentSize: CGSize) {
//        let edgePadding: CGFloat
//
//        let origin = CGPoint(x: desiredOrigin.x, y: desiredOrigin.y + contentSize.height)
//
//        if #available(iOS 11.0, *) {
//            edgePadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 8
//        } else {
//            edgePadding = 8
//        }
//
//        // Check content inside of view or not
//        if !self.frame.contains(origin) {
//            let overFlowY: CGFloat = origin.y - self.frame.size.height + edgePadding
//
//            desiredOrigin = CGPoint(x: desiredOrigin.x, y: desiredOrigin.y - overFlowY)
//        }
//    }
}


class SwiftPopMenuCell: UITableViewCell {
    private var iconImage: UIImageView!
    private var menuItemTitle: UILabel!
    private var seperateLine: UIView!
    private var config: SwiftPopMenuConfig = SwiftPopMenuConfig()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear

        iconImage = UIImageView()
        self.contentView.addSubview(iconImage)
        self.selectionStyle = .blue

        menuItemTitle = UILabel()
        menuItemTitle.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(menuItemTitle)

        seperateLine = UIView()
        seperateLine.backgroundColor = UIColor(red: 222 / 255.0, green: 222 / 255.0, blue: 222 / 255.0, alpha: 0.5)
        self.contentView.addSubview(seperateLine)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(iconImage: String, title: String, config: SwiftPopMenuConfig, islast: Bool = false) {
        self.iconImage.image = UIImage(named: iconImage)
        self.menuItemTitle.text = title
        self.seperateLine.isHidden = islast
        menuItemTitle.textColor = config.menuItemColor
        menuItemTitle.font = config.menuItemFont
        seperateLine.backgroundColor = config.seperateLineBackgroundColor
    }


    override func layoutSubviews() {
        super.layoutSubviews()

        self.iconImage.frame = CGRect(x: config.iconPadding, y: (self.bounds.size.height - config.iconHeight - config.seperateLineHeight) / 2, width: config.iconWidth, height: config.iconHeight)
        let iconWholeWidth = config.iconPadding * 2 + config.iconWidth
        self.menuItemTitle.frame = CGRect(x: iconWholeWidth, y: 0, width: self.bounds.size.width - iconWholeWidth - config.titleEndPadding, height: self.bounds.size.height - config.seperateLineHeight)
        self.seperateLine.frame = CGRect(x: 0, y: self.frame.size.height - config.seperateLineHeight, width: self.frame.size.width, height: config.seperateLineHeight)
    }
}

extension SwiftPopMenu: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popMenuItems!.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if popMenuItems!.count > indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: SwiftPopMenu.cellID) as! SwiftPopMenuCell
            let model = popMenuItems![indexPath.row]
            if indexPath.row == popMenuItems!.count - 1 {
                cell.update(iconImage: model.icon, title: model.title, config: config, islast: true)
            } else {
                cell.update(iconImage: model.icon, title: model.title, config: config)
            }
            return cell
        }

        return UITableViewCell()
    }

}

extension SwiftPopMenu: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return config.menuItemHeight
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwiftPopMenu.cellID) as! SwiftPopMenuCell
        cell.setSelected(false, animated: false)

        self.dismiss()

        let model = popMenuItems![indexPath.row]
        guard let target = model.target,
            let action = model.action else {
                return
        }

        (target as AnyObject).performSelector(onMainThread: action, with: model, waitUntilDone: true)
    }
}
