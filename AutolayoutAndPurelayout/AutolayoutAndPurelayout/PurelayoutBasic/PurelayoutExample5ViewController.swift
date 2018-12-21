//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample5ViewController: BaseViewControllerWithAutolayout {
    lazy var blueView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .blue
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    lazy var redView: UIView = {
        let view = UIView().configureForAutoLayout()
        view.backgroundColor = .red
        return view
    }()
    lazy var purpleLabel: UILabel = {
        let label = UILabel().configureForAutoLayout()
        label.backgroundColor = UIColor(red: 1.0, green: 0, blue: 1.0, alpha: 0.3) // semi-transparent purple
        label.textColor = .white
        label.text = "The quick brown fox jumps over the lazy dog"
        return label
    }()

    override var accessibilityIdentifier: String {
        return "E5"
    }

    override func setupAndComposeView() {
        self.title = "5.Cross-Attribute Constraints"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        [blueView, redView, purpleLabel].forEach { (subview) in
            view.addSubview(subview)
        }
    }

    override func setupConstraints() {
        blueView.autoCenterInSuperview()
        blueView.autoSetDimensions(to: CGSize(width: 150.0, height: 150.0))

        // Use a cross-attribute constraint to constrain an ALAxis (Horizontal) to an ALEdge (Bottom)
        redView.autoConstrainAttribute(.horizontal, to: .bottom, of: blueView)

        redView.autoAlignAxis(.vertical, toSameAxisOf: blueView)
        redView.autoSetDimensions(to: CGSize(width: 50.0, height: 50.0))

        // Use another cross-attribute constraint to place the purpleLabel's baseline on the blueView's top edge
        purpleLabel.autoConstrainAttribute(.baseline, to: .top, of: blueView)

        purpleLabel.autoAlignAxis(.vertical, toSameAxisOf: blueView)

    }

}
