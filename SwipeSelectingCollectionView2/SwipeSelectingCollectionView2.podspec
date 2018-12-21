Pod::Spec.new do |s|

  s.name         = "SwipeSelectingCollectionView2"
  s.version      = "0.1.8"
  s.summary      = "A collection view subclass that enables swipe(finger over) to select multiple cells just like in Photos app."

  s.description  = <<-DESC
This collection view subclass is capable of selecting multiple cells with swipe just finger over cells.
Inspired by Photos app in iOS 9+, derived from SwipeSelectingCollectionView(https://github.com/ShaneQi/SwipeSelectingCollectionView).
                   DESC

  s.homepage     = "https://github.com/dragonetail/SwipeSelectingCollectionView2"
  s.license      = "Apache License 2.0"

  s.author             = { "dragonetail" => "dragonetail@gmail.com" }
  s.social_media_url   = "http://dragonetail.github.io/"

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/dragonetail/SwipeSelectingCollectionView2.git", :tag => "#{s.version}" }

  s.source_files  = "Sources"

end
