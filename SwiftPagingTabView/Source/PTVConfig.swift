
import UIKit

public struct PagingTabViewConfig {
    public var animated: Bool = true
    public var animationDuration: CGFloat = 0.5
    public var tabButtonContainerBorderWidth: CGFloat = 1
    public var tabButtonContainerBorderColor: UIColor = UIColor.lightGray
    public var tabButtonContainerCornerRadius: CGFloat = 0
    public var tabButtonContainerHeight: CGFloat = 36

    public init() {
        //noop
    }
}


public struct TabButtonConfig {
    public var tabButtonHeight: CGFloat = 30
    public var font: UIFont = UIFont.systemFont(ofSize: 12)
    public var fontForSelected: UIFont = UIFont.systemFont(ofSize: 12)
    public var textColor: UIColor = UIColor.lightGray
    public var textColorForSelected: UIColor = UIColor.flatSkyBlueColor()
    public var imageTintColor: UIColor = UIColor.lightGray
    public var imageTintColorForSelected: UIColor = UIColor.flatSkyBlueColor()
    public var imageViewTopDownMargin: CGFloat = 8.0
    public var paddingBetweenImageAndTitle: CGFloat = 5.0
    public var indicatorHeight: CGFloat = 2.0
    public var indicatorColor: UIColor = UIColor.flatSkyBlueColor()
    public var indicatorPlusPadding: CGFloat = 1.0

    public init() {
        //noop
    }
}


extension UIColor {
    fileprivate class func hsb(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor(hue: h / 360.0, saturation: s / 100.0, brightness: b / 100.0, alpha: 1.0)
    }

    class func flatSkyBlueColor() -> UIColor {
        return hsb(204, 76, 86)
    }
    class func flatSkyBlueDarkColor() -> UIColor {
        return hsb(204, 78, 73)
    }
}

