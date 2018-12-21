//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample3ViewController: BaseViewControllerWithAutolayout {
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
        return "E3"
    }

    override func setupAndComposeView() {
        self.title = "3.Distributing Views"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        [blueView, redView, yellowView, greenView].forEach { (subview) in
            view.addSubview(subview)
        }
    }

    override func setupConstraints() {
        let views: NSArray = [redView, blueView, yellowView, greenView]

        // Fix all the heights of the views to 40 pt
        views.autoSetViewsDimension(.height, toSize: 40.0)

        // Distribute the views horizontally across the screen, aligned to one another's horizontal axis,
        // with 10 pt spacing between them and to their superview, and their widths matched equally
        views.autoDistributeViews(along: .horizontal, alignedTo: .horizontal, withFixedSpacing: 10.0, insetSpacing: true, matchedSizes: true)

        // Align the red view to the horizontal axis of its superview.
        // This will end up affecting all the views, since they are all aligned to one another's horizontal axis.
        self.redView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }

}
