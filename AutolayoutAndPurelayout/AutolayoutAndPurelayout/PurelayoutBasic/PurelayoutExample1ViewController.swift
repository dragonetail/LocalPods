//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample1ViewController: BaseViewControllerWithAutolayout {
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
        return "E1"
    }

    override func setupAndComposeView() {
        self.title = "Basic Auto Layout"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        [blueView, redView, yellowView, greenView].forEach { (subview) in
            view.addSubview(subview)
        }
    }

    override func setupConstraints() {
        // Blue view is centered on screen, with size {50 pt, 50 pt}
        blueView.autoCenterInSuperview()
        blueView.autoSetDimensions(to: CGSize(width: 50.0, height: 50.0))

        // Red view is positioned at the bottom right corner of the blue view, with the same width, and a height of 40 pt
        redView.autoPinEdge(.top, to: .bottom, of: blueView)
        redView.autoPinEdge(.left, to: .right, of: blueView)
        redView.autoMatch(.width, to: .width, of: blueView)
        redView.autoSetDimension(.height, toSize: 40.0)

        // Yellow view is positioned 10 pt below the red view, extending across the screen with 20 pt insets from the edges,
        // and with a fixed height of 25 pt
        yellowView.autoPinEdge(.top, to: .bottom, of: redView, withOffset: 10.0)
        yellowView.autoSetDimension(.height, toSize: 25.0)
        yellowView.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        yellowView.autoPinEdge(toSuperviewEdge: .right, withInset: 20.0)

        // Green view is positioned 10 pt below the yellow view, aligned to the vertical axis of its superview,
        // with its height twice the height of the yellow view and its width fixed to 150 pt
        greenView.autoPinEdge(.top, to: .bottom, of: yellowView, withOffset: 10.0)
        greenView.autoAlignAxis(toSuperviewAxis: .vertical)
        greenView.autoMatch(.height, to: .height, of: yellowView, withMultiplier: 2.0)
        greenView.autoSetDimension(.width, toSize: 150.0)
    }

}
