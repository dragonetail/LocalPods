import Foundation

extension String {

   public func extLocalize(fallback: String) -> String {
        let string = NSLocalizedString(self, comment: "")
        return string == self ? fallback : string
    }

    func extHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
//    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
//
//        return ceil(boundingBox.width)
//    }
    
}


//extension NSAttributedString {
//    func extHeight(withConstrainedWidth width: CGFloat) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
//        
//        return ceil(boundingBox.height)
//    }
//    
////    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
////        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
////        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
////
////        return ceil(boundingBox.width)
////    }
//}
