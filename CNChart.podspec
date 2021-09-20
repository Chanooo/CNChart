#
# Be sure to run `pod lib lint CNChart.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CNChart'
  s.version          = '1.0.0'
  s.summary          = 'A simple chart for CocoaPods guide.'
  s.swift_versions   = '5.0'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This library will be used for CocoaPods guide.
                       DESC

  s.homepage         = 'https://github.com/Chanooo/CNChart'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chanooo' => 'kcw9028@naver.com' }
  s.source           = { :git => 'https://github.com/Chanooo/CNChart.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.frameworks = 'UIKit'
  s.source_files = 'CNChart/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CNChart' => ['CNChart/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
