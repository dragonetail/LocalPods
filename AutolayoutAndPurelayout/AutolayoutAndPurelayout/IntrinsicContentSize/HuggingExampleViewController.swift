//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class IntrinsicSampleView: UIView {

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 66)
    }
}


class HuggingExampleViewController: BaseViewControllerWithAutolayout {
    lazy var intrinsicView1: IntrinsicSampleView = {
        let intrinsicView1 = IntrinsicSampleView().configureForAutoLayout("intrinsicView1")
        intrinsicView1.backgroundColor = UIColor.purple

        return intrinsicView1
    }()
    lazy var intrinsicView2: IntrinsicSampleView = {
        let intrinsicView2 = IntrinsicSampleView().configureForAutoLayout("intrinsicView2")
        intrinsicView2.backgroundColor = UIColor.purple

        return intrinsicView2
    }()

    override var accessibilityIdentifier: String {
        return "Hugging"
    }

    override func setupAndComposeView() {
        self.title = "拉伸能力优先级测试"

        [intrinsicView1, intrinsicView2].forEach { (subview) in
            view.addSubview(subview)
        }
    }


    override func setupConstraints() {
        intrinsicView1.autoAlignAxis(toSuperviewAxis: .vertical)
        intrinsicView1.autoPinEdge(toSuperviewSafeArea: .top)

        intrinsicView2.autoAlignAxis(toSuperviewAxis: .vertical)
        intrinsicView2.autoPinEdge(toSuperviewSafeArea: .bottom)

        print(intrinsicView2.contentHuggingPriority(for: .vertical))
        //设置比缺省值小，则容易被拉伸
        intrinsicView2.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        print(intrinsicView2.contentHuggingPriority(for: .vertical))

        intrinsicView2.autoPinEdge(.top, to: .bottom, of: intrinsicView1, withOffset: 50)
    }

}
