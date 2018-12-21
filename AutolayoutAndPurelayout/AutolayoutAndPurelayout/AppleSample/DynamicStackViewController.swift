//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

// Ref: https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html#//apple_ref/doc/uid/TP40010853-CH11-SW1
class DynamicStackViewController: BaseViewControllerWithAutolayout {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView().configureForAutoLayout("scrollView")

        // setup scrollview
        let insets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets

        return scrollView
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView().configureForAutoLayout("stackView")

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10

        return stackView
    }()
    lazy var addButton: UIButton = {
        let button = UIButton(type: .roundedRect).configureForAutoLayout()
        button.accessibilityIdentifier = "addButton"
        button.setTitle("Add Entry", for: .normal)
        return button
    }()

    override var accessibilityIdentifier: String {
        return "DynamicStackView"
    }

    override func setupAndComposeView() {
        self.title = "Dynamic Stack View"

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(addButton)
        addButton.addTarget(self, action: #selector(self.addEntry(_:)), for: .touchUpInside)

        addEntry(addButton)
    }

    override func setupConstraints() {
//        Scroll View.Leading = Superview.LeadingMargin
//        Scroll View.Trailing = Superview.TrailingMargin
//        Scroll View.Top = Superview.TopMargin
//        Bottom Layout Guide.Top = Scroll View.Bottom + 20.0
//        Stack View.Leading = Scroll View.Leading
//        Stack View.Trailing = Scroll View.Trailing
//        Stack View.Top = Scroll View.Top
//        Stack View.Bottom = Scroll View.Bottom
//        Stack View.Width = Scroll View.Width
        scrollView.autoPinEdge(toSuperviewMargin: .leading)
        scrollView.autoPinEdge(toSuperviewMargin: .trailing)
        scrollView.autoPinEdge(toSuperviewMargin: .top)
        scrollView.autoPinEdge(toSuperviewMargin: .bottom, withInset: 20)

        stackView.autoPinEdge(toSuperviewEdge: .leading)
        stackView.autoPinEdge(toSuperviewEdge: .trailing)
        stackView.autoPinEdge(toSuperviewEdge: .top)
        stackView.autoPinEdge(toSuperviewEdge: .bottom)
        stackView.autoMatch(.width, to: .width, of: scrollView)

        //addButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)//追加到StackView中的内容不需要设置上下边界
        addButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    var entryCount = 1
    // MARK: - Private Methods
    private func createEntry() -> UIView {
        let date = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .short, timeStyle: .none)
        let number = "\(entryCount)-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())"

        let stack = UIStackView().configureForAutoLayout()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .fill
        stack.spacing = 8

        let dateLabel = UILabel().configureForAutoLayout()
        dateLabel.text = date
        dateLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)

        let numberLabel = UILabel().configureForAutoLayout()
        numberLabel.text = number
        numberLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)

        let deleteButton = UIButton(type: .roundedRect).configureForAutoLayout()
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(self.deleteEntry(_:)), for: .touchUpInside)

        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(deleteButton)

        stack.tag = entryCount
        entryCount = entryCount + 1
        return stack
    }

    private func randomHexQuad() -> String {
        let hexStr = NSString(format: "%X%X%X%X",
                              arc4random() % 16,
                              arc4random() % 16,
                              arc4random() % 16,
                              arc4random() % 16
        ) as String
        return hexStr
    }

    @objc func addEntry(_ sender: UIButton) {
        let stack = stackView
        let index = stack.arrangedSubviews.count - 1
        let addView = stack.arrangedSubviews[index]

        let scroll = scrollView
        let offset = CGPoint(x: scroll.contentOffset.x,
                             y: scroll.contentOffset.y + addView.frame.size.height)

        let newView = createEntry()
        newView.isHidden = true
        stack.insertArrangedSubview(newView, at: index)

        UIView.animate(withDuration: 0.25) { () -> Void in
            newView.isHidden = false
            scroll.contentOffset = offset
        }
    }
    @objc func deleteEntry(_ sender: UIButton) {
        if let view = sender.superview {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                view.isHidden = true
            }, completion: { (success) -> Void in
                print("view.tag: \(view.tag)")
                view.removeFromSuperview()
            })
        }
    }
}
