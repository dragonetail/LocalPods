import UIKit
import UIKit.UIGestureRecognizerSubclass

class SwipeSelectingGestureRecognizer: UIPanGestureRecognizer {

    // Assist in determining whether the initial movement is horizontal or vertical
	private var startPoint: CGPoint?

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesBegan(touches, with: event)
		startPoint = touches.first?.location(in: self.view)
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
		defer {
			super.touchesMoved(touches, with: event)
			self.startPoint = nil
		}
		guard let view = self.view,
			let touchPoint = touches.first?.location(in: view),
			let startPoint = self.startPoint else {
				return
		}
        
        // Determining whether the initial movement is horizontal or vertical
		let deltaY = abs(startPoint.y - touchPoint.y)
		let deltaX = abs(startPoint.x - touchPoint.x)
		if deltaY != 0 && deltaY / deltaX > 1 {
			state = .failed
			return
		}
	}

}
