import UIKit

public extension UIViewController {

    public var sideMenuController: TabMenuController? {
        return findTabMenuController(from: self)
    }

    fileprivate func findTabMenuController(from viewController: UIViewController) -> TabMenuController? {
        var sourceViewController: UIViewController? = viewController
        repeat {
            sourceViewController = sourceViewController?.parent
            if let sideMenuController = sourceViewController as? TabMenuController {
                return sideMenuController
            }
        } while (sourceViewController != nil)
        return nil
    }
}
