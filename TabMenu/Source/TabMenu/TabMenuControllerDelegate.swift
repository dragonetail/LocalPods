import Foundation
import UIKit

// Delegate Methods
@objc public protocol TabMenuControllerDelegate: class {

    /// 允许定制化非交互视图转换的动画控制。
    /// 参考 `navigationController:animationControllerForOperation:fromViewController:toViewController:`
    @objc optional func tabMenuController(_ tabMenuController: TabMenuController,
                                     animationControllerFrom fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?

    @objc optional func tabMenuController(_ tabMenuController: TabMenuController, willShow viewController: UIViewController, animated: Bool)
    @objc optional func tabMenuController(_ tabMenuController: TabMenuController, didShow viewController: UIViewController, animated: Bool)

    @objc optional func tabMenuControllerWillOpenMenu(_ tabMenuController: TabMenuController)
    @objc optional func tabMenuControllerDidOpenMenu(_ tabMenuController: TabMenuController)
    @objc optional func tabMenuControllerWillHideMenu(_ tabMenuController: TabMenuController)
    @objc optional func tabMenuControllerDidHideMneu(_ tabMenuController: TabMenuController)
}

