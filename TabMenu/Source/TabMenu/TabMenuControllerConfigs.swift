import Foundation
import UIKit

extension TabMenuController {
    public struct Configs {

        /// 状态栏动画行为。
        ///
        /// - none: 状态栏保持显示
        /// - slide: 状态栏向上滑出
        /// - fade: 状态栏淡出
        /// - hideOnMenu: 状态栏直接隐藏
        public enum StatusBarBehavior: CaseIterable {
            case none
            case slide
            case fade
            case hideOnMenu
        }

        /// 侧栏菜单方向。
        public enum MenuDirection: CaseIterable {
            case left
            case right
        }

        /// 侧栏菜单位置
        ///
        /// - above: 侧栏菜单置于内容视图之上
        /// - under: 侧栏菜单置于内容视图之下
        /// - sideBySide: 侧栏菜单与内容视图同层
        public enum MenuPosition: CaseIterable {
            case above
            case under
            case sideBySide
        }

        public struct Animation {
            public var openDuration: TimeInterval = 0.4
            public var hideDuration: TimeInterval = 0.4
            public var animationOptions: UIView.AnimationOptions = .curveEaseInOut
            public var dampingRatio: CGFloat = 1
            public var initialSpringVelocity: CGFloat = 1
            public var shouldAddShadowWhenOpenning = true
            public var shadowAlpha: CGFloat = 0.2
        }

        public var tabMenuWidth: CGFloat = 280
        public var position: MenuPosition = .above
        public var direction: MenuDirection = .left
        public var statusBarBehavior: StatusBarBehavior = .none

        //是否需要遵循本地化语言的UI方向
        public var shouldRespectLanguageDirection = true

        public var enablePanGesture = true
        public var enableRubberEffectWhenPanning = true
        public var hideMenuWhenEnteringBackground = false

        public var defaultCacheKey: String = "main"
        public var supportedOrientations: UIInterfaceOrientationMask = .all

        public var enableTransitionAnimation = true
        public var animation = Animation()
    }
}
