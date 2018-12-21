import Foundation

extension String {

   public func extLocalize(fallback: String) -> String {
        let string = NSLocalizedString(self, comment: "")
        return string == self ? fallback : string
    }

}
