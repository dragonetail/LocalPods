//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample10ViewController: BaseViewControllerWithAutolayout {
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
    lazy var toggleConstraintsButton: UIButton = {
        let button = UIButton().configureForAutoLayout()
        button.setTitle("Toggle Constraints", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.setTitleColor(.gray, for: .highlighted)
        return button
    }()

    override var accessibilityIdentifier: String {
        return "E10"
    }

    override func setupAndComposeView() {
        self.title = "10.Constraints Without Installing"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        [blueView, redView, yellowView, greenView, toggleConstraintsButton].forEach { (subview) in
            view.addSubview(subview)
        }
        toggleConstraintsButton.addTarget(self, action: #selector(PurelayoutExample10ViewController.toggleConstraints(_:)), for: .touchUpInside)
    }

    // Properties to store the constraints for each of the two layouts. Only one set of these will be installed at any given time.
    var horizontalLayoutConstraints: NSArray?
    var verticalLayoutConstraints: NSArray?
    override func setupConstraints() {
        let views: NSArray = [redView, blueView, yellowView, greenView]

        // Create and install the constraints that define the horizontal layout, because this is the one we're starting in.
        // Note that we use autoCreateAndInstallConstraints() here in order to easily collect all the constraints into a single array.
        horizontalLayoutConstraints = NSLayoutConstraint.autoCreateAndInstallConstraints {
            views.autoSetViewsDimension(.height, toSize: 40.0)
            views.autoDistributeViews(along: .horizontal, alignedTo: .horizontal, withFixedSpacing: 10.0, insetSpacing: true, matchedSizes: true)
            self.redView.autoAlignAxis(toSuperviewAxis: .horizontal)
        } as NSArray?

        // Create the constraints that define the vertical layout, but don't install any of them - just store them for now.
        // Note that we use autoCreateConstraintsWithoutInstalling() here in order to both prevent the constraints from being installed automatically,
        // and to easily collect all the constraints into a single array.
        verticalLayoutConstraints = NSLayoutConstraint.autoCreateConstraintsWithoutInstalling {
            views.autoSetViewsDimension(.width, toSize: 60.0)
            views.autoDistributeViews(along: .vertical, alignedTo: .vertical, withFixedSpacing: 70.0, insetSpacing: true, matchedSizes: true)
            self.redView.autoAlignAxis(toSuperviewAxis: .vertical)
        } as NSArray?

        toggleConstraintsButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10.0)
        toggleConstraintsButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    // Flag that we use to know which layout we're currently in. We start with the horizontal layout.
    var isHorizontalLayoutActive = true

    /**
     Callback when the "Toggle Constraints" button is tapped.
     */
    @objc func toggleConstraints(_ sender: UIButton) {
        isHorizontalLayoutActive = !isHorizontalLayoutActive

        if (isHorizontalLayoutActive) {
            verticalLayoutConstraints?.autoRemoveConstraints()
            horizontalLayoutConstraints?.autoInstallConstraints()
        } else {
            horizontalLayoutConstraints?.autoRemoveConstraints()
            verticalLayoutConstraints?.autoInstallConstraints()
        }

        /**
         Uncomment the below code if you want the transitions to be animated!
         */
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
