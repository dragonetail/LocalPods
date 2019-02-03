import UIKit

extension UIViewController {
    func load(_ viewController: UIViewController?, on view: UIView) {
        guard let viewController = viewController else {
            return
        }

        // `willMoveToParentViewController:` is called automatically when adding
        addChild(viewController)

        viewController.view.frame = view.bounds
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(viewController.view)

        viewController.didMove(toParent: self)
    }

    func unload(_ viewController: UIViewController?) {
        guard let viewController = viewController else {
            return
        }

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        // `didMoveToParentViewController:` is called automatically when removing
    }
}
