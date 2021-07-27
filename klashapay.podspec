#
# Be sure to run `pod lib lint klashapay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'klashapay'
  s.version          = '0.1.0'
  s.summary          = 'A short description of klashapay.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/debugher/klashapay'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'debugher' => 'ayodaniel@iflux.app' }
  s.source           = { :git => 'https://github.com/debugher/klashapay.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'klashapay/Classes/**/*'
  s.resources =  'klashapay/**/*.{storyboard,xib,xcassets,json,png, jpeg, ttf}'
  # s.resource_bundles = {
  #   'klashapay' => ['klashapay/Assets/*.png']
  # }
#  s.resource_bundles = {
#      'klashapay' => [
#          'Pod/**/*.xib'
#      ]
#    }
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'    s.frameworks = 'UIKit'
  s.dependency 'lottie-ios'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'SwinjectAutoregistration'
  s.dependency 'Swinject'
  s.dependency 'MaterialComponents/TextControls+OutlinedTextAreas'
  s.dependency 'MaterialComponents/TextControls+OutlinedTextFields'
  s.dependency 'MaterialComponents/TextControls+FilledTextFields'
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'OTPFieldView'
  s.dependency 'PopupDialog'
end
