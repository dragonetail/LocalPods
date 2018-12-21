import UIKit
import PureLayout
import SwiftBaseBootstrap

open class TabButton: BaseViewWithAutolayout {
    open var config: TabButtonConfig = TabButtonConfig() {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsUpdateConstraints()
        }
    }

    open lazy var containerView: UIView = {
        let containerView = UIView().autoLayout("containerView")
        
        addSubview(containerView)
        return containerView
    }()
    open var imageView: UIImageView?
    open var titleLabel: UILabel?
    open lazy var indicatorView: UIView = {
        let indicatorView = UIView().autoLayout("indicatorView")

        addSubview(indicatorView)
        return indicatorView
    }()

    open var isSelected: Bool = false {
        didSet {
            if isSelected {
                titleLabel?.font = config.fontForSelected
                titleLabel?.textColor = config.textColorForSelected
                imageView?.tintColor = config.imageTintColorForSelected
                indicatorView.isHidden = false
                indicatorView.backgroundColor = self.config.indicatorColor
            } else {
                titleLabel?.font = config.font
                titleLabel?.textColor = config.textColor
                imageView?.tintColor = config.imageTintColor
                indicatorView.isHidden = true
            }
        }
    }

    open var title: String? {
        didSet {
            guard let title = title else {
                return
            }
            self.titleLabel = UILabel().autoLayout("titleLabel")
            self.titleLabel?.text = title

            containerView.addSubview(self.titleLabel!)
        }
    }

    open var image: UIImage? {
        didSet {
            guard let image = image else {
                return
            }
            self.imageView = UIImageView().autoLayout("imageView")
            self.imageView?.image = image.withRenderingMode(.alwaysTemplate)
            imageView?.clipsToBounds = true
            imageView?.contentMode = .scaleToFill
            containerView.addSubview(self.imageView!)
        }
    }

    open override func setupAndComposeView() {
        self.invalidateIntrinsicContentSize()
        self.setNeedsUpdateConstraints()
    }

    // invoked only once
    open override func setupConstraints() {
        self.autoSetDimension(.height, toSize: config.tabButtonHeight)
        containerView.autoCenterInSuperview()
        let imageSize = config.tabButtonHeight - config.imageViewTopDownMargin * 2

        var indicatorViewTopAlign: UIView!
        if let imageView = self.imageView {
            indicatorViewTopAlign = imageView
            imageView.autoPinEdge(toSuperviewEdge: .left, withInset: config.indicatorPlusPadding)
            imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
            imageView.autoAlignAxis(toSuperviewAxis: .vertical)
            imageView.autoSetDimensions(to: CGSize(width: imageSize, height: imageSize))
        }

        if let titleLabel = self.titleLabel {
            indicatorViewTopAlign = titleLabel
            titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            if let imageView = self.imageView {
                indicatorViewTopAlign = imageView
                titleLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: config.paddingBetweenImageAndTitle)
            } else {
                titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: config.indicatorPlusPadding)
                titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            }
        }
        indicatorView.autoPinEdge(.top, to: .bottom, of: indicatorViewTopAlign, withOffset: 2)
        indicatorView.autoSetDimension(.width, toSize: intrinsicContentSize.width)
        indicatorView.autoSetDimension(.height, toSize: config.indicatorHeight)
        indicatorView.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    open override var intrinsicContentSize: CGSize {
        titleLabel?.sizeToFit()

        let imageSize = config.tabButtonHeight - config.imageViewTopDownMargin * 2

        var width: CGFloat = config.indicatorPlusPadding * 2
        if let _ = imageView {
            width = width + imageSize
            if let _ = titleLabel {
                width = width + config.paddingBetweenImageAndTitle
            }
        }
        if let titleLabelWidth = titleLabel?.frame.size.width {
            width = width + titleLabelWidth
        }
        return CGSize(width: width, height: config.tabButtonHeight)
    }
}
