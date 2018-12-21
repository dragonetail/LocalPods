import UIKit
import Photos

class PhotoCell: UICollectionViewCell {
    static let Identifier = "PhotoCellIdentifier"

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill

        #if os(iOS)
            view.clipsToBounds = true
        #else
            view.clipsToBounds = false
            view.adjustsImageWhenAncestorFocused = true
        #endif

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .black
        self.addSubview(self.imageView)
        self.addSubview(self.videoIndicator)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var videoIndicator: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "video-indicator")!
        view.isHidden = true
        view.contentMode = .center

        return view
    }()

    var photo: Photo? {
        didSet {
            guard let photo = self.photo else {
                self.imageView.image = nil
                return
            }

            self.videoIndicator.isHidden = photo.type == .image

            if let assetID = photo.assetID, let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetID], options: nil).firstObject, let image = Photo.thumbnail(for: asset) {
                self.imageView.image = image
            } else {
                self.imageView.image = photo.placeholder
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.videoIndicator.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
}
