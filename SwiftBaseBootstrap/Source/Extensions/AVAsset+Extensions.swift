import UIKit
import AVFoundation

extension AVAsset {

    fileprivate var extNaturalSize: CGSize {
        return tracks(withMediaType: AVMediaType.video).first?.naturalSize ?? .zero
    }

    var extCorrectSize: CGSize {
        return extIsPortrait ? CGSize(width: extNaturalSize.height, height: extNaturalSize.width): extNaturalSize
    }

    var extIsPortrait: Bool {
        let portraits: [UIInterfaceOrientation] = [.portrait, .portraitUpsideDown]
        return portraits.contains(extOrientation)
    }

    var extFileSize: Double {
        guard let avURLAsset = self as? AVURLAsset else { return 0 }

        var result: AnyObject?
        try? (avURLAsset.url as NSURL).getResourceValue(&result, forKey: URLResourceKey.fileSizeKey)

        if let result = result as? NSNumber {
            return result.doubleValue
        } else {
            return 0
        }
    }

    var extFrameRate: Float {
        return tracks(withMediaType: AVMediaType.video).first?.nominalFrameRate ?? 30
    }

    // Same as UIImageOrientation
    var extOrientation: UIInterfaceOrientation {
        guard let transform = tracks(withMediaType: AVMediaType.video).first?.preferredTransform else {
            return .portrait
        }

        switch (transform.tx, transform.ty) {
        case (0, 0):
            return .landscapeRight
        case (extNaturalSize.width, extNaturalSize.height):
            return .landscapeLeft
        case (0, extNaturalSize.width):
            return .portraitUpsideDown
        default:
            return .portrait
        }
    }

    // MARK: - Description
    var extVideoDescription: CMFormatDescription? {
        guard let object = tracks(withMediaType: AVMediaType.video).first?.formatDescriptions.first else {
            return nil
        }

        return (object as! CMFormatDescription)
    }

    var extAudioDescription: CMFormatDescription? {
        guard let object = tracks(withMediaType: AVMediaType.audio).first?.formatDescriptions.first else {
            return nil
        }

        return (object as! CMFormatDescription)
    }
}
