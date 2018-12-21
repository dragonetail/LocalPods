import UIKit

extension UIScrollView {
    public func extScrollToTop() {
        setContentOffset(CGPoint.zero, animated: false)
    }

    public func extUpdateBottomInset(_ value: CGFloat) {
        var inset = contentInset
        inset.bottom = value

        contentInset = inset
        scrollIndicatorInsets = inset
    }

    public var extContentOffsetRatio: CGPoint { // = CGPoint(x: 0.5, y: 0.5)
        let offsetX = self.contentOffset.x
        let offsetY = self.contentOffset.y
        let x = offsetX == 0 ? 0 : round(offsetX / self.frame.size.width)
        let y = offsetY == 0 ? 0 : round(offsetY / self.frame.size.height)
        return CGPoint(x: x, y: y)
    }

    public func extUpdateContentOffset(_ ratio: CGPoint) {
        var offsetX = ratio.x * self.frame.size.width
        var offsetY = ratio.y * self.frame.size.height

        offsetX = offsetX > 0.0 ? offsetX : 0.0
        offsetY = offsetY > 0.0 ? offsetY : 0.0
        var  maxX = self.contentSize.width - self.frame.size.width
        var  maxY = self.contentSize.height - self.frame.size.height
        maxX = maxX > 0.0 ? maxX : 0.0
        maxY = maxY > 0.0 ? maxY : 0.0
        offsetX = offsetX > maxX ? maxX : offsetX
        offsetY = offsetY > maxY ? maxY : offsetY
        self.contentOffset = CGPoint(x: offsetX, y: offsetY)
    }
}
