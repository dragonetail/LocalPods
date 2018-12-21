//
//  UIPaddedLabel.swift
//  PhotoSaver
//
//  Created by dragonetail on 2018/12/16.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit

open class UIPaddedLabel: UILabel {

    public var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    //Note: Fix UILabel bug in iOS 11
    //Refs: https://stackoverflow.com/questions/48211895/how-to-fix-uilabel-intrinsiccontentsize-on-ios-11
    // https://gist.github.com/samskiter/8f420d37b9a6bb6b3c6639e016698ece
    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        if size.width > UIScreen.main.bounds.width { // the invalid width is 2777777
            let oldNumberOfLines = self.numberOfLines
            self.numberOfLines = 1
            size = super.intrinsicContentSize
            self.numberOfLines = oldNumberOfLines
        }
        size = CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
        return size
    }
}
