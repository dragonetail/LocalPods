//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample2ViewController: BaseViewControllerWithAutolayout {
    lazy var blueView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .blue
        return view
    }()
    lazy var redView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .red
        return view
    }()
    lazy var yellowView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .yellow
        return view
    }()
    lazy var greenView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .green
        return view
    }()

    override var accessibilityIdentifier: String {
        return "E2"
    }

    override func setupAndComposeView() {
        self.title = "2.Working with Arrays of Views"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        [blueView, redView, yellowView, greenView].forEach { (subview) in
            view.addSubview(subview)
        }
    }

    override func setupConstraints() {
        ([redView, yellowView] as NSArray).autoSetViewsDimension(.height, toSize: 50.0)
        ([blueView, greenView] as NSArray).autoSetViewsDimension(.height, toSize: 70.0)

        let views = [redView, blueView, yellowView, greenView]

        // Match the widths of all the views
        (views as NSArray).autoMatchViewsDimension(.width)

        // Pin the red view 20 pt from the top layout guide of the view controller
        redView.autoPin(toTopLayoutGuideOf: self, withInset: 20.0)

        // Loop over the views, attaching the left edge to the previous view's right edge,
        // and the top edge to the previous view's bottom edge
        views.first?.autoPinEdge(toSuperviewEdge: .left)
        var previousView: UIView?
        for view in views {
            if let previousView = previousView {
                view.autoPinEdge(.left, to: .right, of: previousView)
                view.autoPinEdge(.top, to: .bottom, of: previousView)
            }
            previousView = view
        }
        views.last?.autoPinEdge(toSuperviewEdge: .right)
    }

}
