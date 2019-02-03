import UIKit

public extension UIViewController {

    public var tabMenuController: TabMenuController? {
        return findTabMenuController(from: self)
    }

    fileprivate func findTabMenuController(from viewController: UIViewController) -> TabMenuController? {
        var sourceViewController: UIViewController? = viewController
        repeat {
            sourceViewController = sourceViewController?.parent
            if let tabMenuController = sourceViewController as? TabMenuController {
                return tabMenuController
            }
        } while (sourceViewController != nil)
        return nil
    }
}
