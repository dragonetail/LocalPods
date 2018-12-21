//
//  ExampleViewControllerType.swift
//  AutolayoutAndPurelayout
//
//  Created by 孙玉新 on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

class UIViewControllerWithAutolayout: UIViewController {

    override func loadView() {
        super.loadView()

        setupAndComposeView()

        // bootstrap Auto Layout
        view.setNeedsUpdateConstraints()
    }

    // Should overritted by subclass, setup view and compose subviews
    func setupAndComposeView() {
        // View setup
        //self.title = "UIViewControllerWithAutolayout Sample"
        //view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        // Compose subviews
        //[label1, label2].forEach { (subview) in
        //    view.addSubview(subview)
        //}
    }

    fileprivate var didSetupConstraints = false
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            setupConstraints()
        }
        modifyConstraints()

        super.updateViewConstraints()
    }

    // invoked only once
    func setupConstraints() {

    }

    // invoked every times when trigged by setNeedsUpdateConstraints()
    func modifyConstraints() {

    }
}
