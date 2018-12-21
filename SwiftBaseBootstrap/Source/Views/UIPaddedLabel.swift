//
//  UIPaddedLabel.swift
//  PhotoSaver
//
//  Created by dragonetail on 2018/12/16.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

open class UIPaddedLabel: UILabel {

    public var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }

    open override func sizeToFit() {
        super.sizeThatFits(intrinsicContentSize)
    }
}
