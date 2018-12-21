import UIKit

public extension UIView {
    public func extRoundBorder(_ color: UIColor = UIColor.purple, borderWidth: CGFloat = 1, cornerRadius: CGFloat = 3, clipsToBounds: Bool = true) {
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
    }

    public func extShadow(_ color: UIColor = UIColor.black, shadowOpacity: Float = 0.5, shadowOffset: CGSize = CGSize(width: 0, height: 1), shadowRadius: CGFloat = 1) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }


    public func extQuickFade(_ visible: Bool = true, duration: TimeInterval = 0.1) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = visible ? 1 : 0
        })
    }

    public func extFade(_ visible: Bool, duration: TimeInterval = 0.25, completion: (()->Void)? = nil) {
        if visible {
            self.isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = visible ? 1 : 0
        }, completion: { [weak self] _ in
            if !visible {
                self?.isHidden = true
            }
            completion?()
        })
    }

    public func extHide(_completion: (()->Void)? = nil) {
        extFade(false, completion: _completion)
    }

    public func extShow(completion: (()->Void)? = nil) {
        extFade(true, completion: completion)
    }
}
