import UIKit


extension UIView.ContentMode: CustomStringConvertible {
	public var description: String {
		switch self {
		case .scaleToFill:
			return "scaleToFill"
		case .scaleAspectFit:
			return "scaleAspectFit"
		case .scaleAspectFill:
			return "scaleAspectFill"
		case .redraw:
			return "redraw"
		case .center:
			return "center"
		case .top:
			return "top"
		case .bottom:
			return "bottom"
		case .left:
			return "left"
		case .right:
			return "right"
		case .topLeft:
			return "topLeft"
		case .topRight:
			return "topRight"
		case .bottomLeft:
			return "bottomLeft"
		case .bottomRight:
			return "bottomRight"
		}
	}
}
