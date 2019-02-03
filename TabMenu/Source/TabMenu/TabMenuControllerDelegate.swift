import Foundation
import UIKit

// Delegate Methods
@objc public protocol TabMenuControllerDelegate: class {

    /// 允许定制化非交互视图转换的动画控制。
    /// 参考 `navigationController:animationControllerForOperation:fromViewController:toViewController:`
    @objc optional func sideMenuController(_ sideMenuController: TabMenuController,
                                     animationControllerFrom fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?

    @objc optional func sideMenuController(_ sideMenuController: TabMenuController, willShow viewController: UIViewController, animated: Bool)
    @objc optional func sideMenuController(_ sideMenuController: TabMenuController, didShow viewController: UIViewController, animated: Bool)

    @objc optional func sideMenuControllerWillOpenMenu(_ sideMenuController: TabMenuController)
    @objc optional func sideMenuControllerDidOpenMenu(_ sideMenuController: TabMenuController)
    @objc optional func sideMenuControllerWillHideMenu(_ sideMenuController: TabMenuController)
    @objc optional func sideMenuControllerDidHideMneu(_ sideMenuController: TabMenuController)
}

