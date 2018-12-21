//
//  ViewController.swift
//  AutolayoutAndPurelayout
//
//  Created by dragonetail on 2018/12/11.
//  Copyright © 2018 dragonetail. All rights reserved.
//

import UIKit
import PureLayout

class PurelayoutExample11ViewController: BaseViewControllerWithAutolayout {
    lazy var scrollView = UIScrollView.newAutoLayout()
    let contentView = UIView.newAutoLayout()

    lazy var blueLabel: UILabel = {
        let label = UILabel().configureForAutoLayout("blueLabel")
        label.backgroundColor = .blue
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .white
        label.text = NSLocalizedString("Auto Layout dynamically calculates the size and position of all the views in your view hierarchy, based on constraints placed on those views. For example, you can constrain a button so that it is horizontally centered with an Image view and so that the button’s top edge always remains 8 points below the image’s bottom. If the image view’s size or position changes, the button’s position automatically adjusts to match. This constraint-based approach to design allows you to build user interfaces that dynamically respond to both internal and external changes. When your app’s content changes, the new content may require a different layout than the old. This commonly occurs in apps that display text or images. For example, a news app needs to adjust its layout based on the size of the individual news articles. Similarly, a photo collage must handle a wide range of image sizes and aspect ratios.Internationalization is the process of making your app able to adapt to different languages, regions, and cultures. The layout of an internationalized app must take these differences into account and appear correctly in all the languages and regions that the app supports. Internationalization has three main effects on layout. First, when you translate your user interface into a different language, the labels require a different amount of space. German, for example, typically requires considerably more space than English. Japanese frequently requires much less. Second, the format used to represent dates and numbers can change from region to region, even if the language does not change. Although these changes are typically more subtle than the language changes, the user interface still needs to adapt to the slight variation in size. Third, changing the language can affect not just the size of the text, but the organization of the layout as well. Different languages use different layout directions. English, for example, uses a left-to-right layout direction, and Arabic and Hebrew use a right-to-left layout direction. In general, the order of the user interface elements should match the layout direction. If a button is in the bottom-right corner of the view in English, it should be in the bottom left in Arabic.  Finally, if your iOS app supports dynamic type, the user can change the font size used in your app. This can change both the height and the width of any textual elements in your user interface. If the user changes the font size while your app is running, both the fonts and the layout must adapt.", comment: "")
        return label
    }()

    override var accessibilityIdentifier: String {
        return "E11"
    }

    override func setupAndComposeView() {
        self.title = "11.Basic UIScrollView"
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(blueLabel)
    }

    override func setupConstraints() {
        scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)

        contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        contentView.autoMatch(.width, to: .width, of: view)

        blueLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        blueLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        blueLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        blueLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
    }

}
