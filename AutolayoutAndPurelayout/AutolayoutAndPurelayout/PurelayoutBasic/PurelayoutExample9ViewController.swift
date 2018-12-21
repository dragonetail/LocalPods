//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample9ViewController: BaseViewControllerWithAutolayout {
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
        return "E9"
    }

    override func setupAndComposeView() {
        self.title = "9.Layout Margins (iOS 8.0+)"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        view.addSubview(blueView)
        blueView.addSubview(redView)
        redView.addSubview(yellowView)
        yellowView.addSubview(greenView)
    }

    override func setupConstraints() {
        // Before layout margins were introduced, this is a typical way of giving a subview some padding from its superview's edges
        blueView.autoPin(toTopLayoutGuideOf: self, withInset: 10.0)
        blueView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 10.0, bottom: 10.0, right: 10.0), excludingEdge: .top)

        // Set the layoutMargins of the blueView, which will have an effect on subviews of the blueView that attach to
        // the blueView's margin attributes -- in this case, the redView
        blueView.layoutMargins = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 80.0, right: 20.0)
        redView.autoPinEdgesToSuperviewMargins()

        // Let the redView inherit the values we just set for the blueView's layoutMargins by setting the below property to YES.
        // Then, pin the yellowView's edges to the redView's margins, giving the yellowView the same insets from its superview as the redView.
        redView.preservesSuperviewLayoutMargins = true
        yellowView.autoPinEdge(toSuperviewMargin: .left)
        yellowView.autoPinEdge(toSuperviewMargin: .right)

        // By aligning the yellowView to its superview's horizontal margin axis, the yellowView will be positioned with its horizontal axis
        // in the middle of the redView's top and bottom margins (causing it to be slightly closer to the top of the redView, since the
        // redView has a much larger bottom margin than top margin).
        yellowView.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        yellowView.autoMatch(.height, to: .height, of: redView, withMultiplier: 0.5)

        // Since yellowView.preservesSuperviewLayoutMargins is NO by default, it will not preserve (inherit) its superview's margins,
        // and instead will just have the default margins of: {8.0, 8.0, 8.0, 8.0} which will apply to its subviews (greenView)
        greenView.autoPinEdges(toSuperviewMarginsExcludingEdge: .bottom)
        greenView.autoSetDimension(.height, toSize: 50.0)
    }

}
