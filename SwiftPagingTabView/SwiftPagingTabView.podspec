#
# Be sure to run `pod lib lint SwiftPagingTabView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftPagingTabView'
  s.version          = '0.1.7'
  s.summary          = 'Paging Tab View implement in swift4.2.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Paging Tab View implement in swift4.2 using ScrollView and configurable design.
                       DESC

  s.homepage         = 'https://github.com/dragonetail/SwiftPagingTabView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dragonetail' => 'dragonetail@gmail.com' }
  s.source           = { :git => 'https://github.com/dragonetail/SwiftPagingTabView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.source_files = 'Source/**/*'
  
  # s.resource_bundles = {
  #   'SwiftPagingTabView' => ['SwiftPagingTabView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'PureLayout', '~> 3.1.4'
  s.dependency 'SwiftBaseBootstrap'
end
