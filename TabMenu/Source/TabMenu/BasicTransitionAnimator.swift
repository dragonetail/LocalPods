import UIKit

public class BasicTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animationOptions: UIView.AnimationOptions
    let duration: TimeInterval

    public init(options: UIView.AnimationOptions = .transitionCrossDissolve, duration: TimeInterval = 0.4) {
        animationOptions = options
        self.duration = duration
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else {
                return
        }

        transitionContext.containerView.addSubview(toViewController.view)

        let duration = transitionDuration(using: transitionContext)

        UIView.transition(from: fromViewController.view,
                          to: toViewController.view,
                          duration: duration,
                          options: animationOptions
        ) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
