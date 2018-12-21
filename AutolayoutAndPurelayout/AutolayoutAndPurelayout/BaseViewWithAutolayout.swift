//
//  BaseViewWithAutolayout.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/13.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

class BaseViewWithAutolayout: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        _ = self.configureForAutoLayout("BaseViewWAL")

        setupAndComposeView()

        // bootstrap Auto Layout
        self.setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Should overritted by subclass, setup view and compose subviews
    func setupAndComposeView() {
    }

    fileprivate var didSetupConstraints = false
    override func updateConstraints() {
        if (!didSetupConstraints) {
            didSetupConstraints = true
            setupConstraints()
        }
        modifyConstraints()

        super.updateConstraints()
    }

    // invoked only once
    func setupConstraints() {
    }
    func modifyConstraints() {
    }
}

