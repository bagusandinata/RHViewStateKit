#
# Be sure to run `pod lib lint RHViewStateKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'RHViewStateKit'
  s.version               = '1.0.1'
  s.summary               = 'RHViewState provides fully customizable configuration to change state in your view'
  s.platform              = :ios
  s.ios.deployment_target = '10.0'
  s.swift_version         = '5.1'
  s.requires_arc          = true
  s.homepage              = 'https://github.com/bagusandinata/RHViewStateKit'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'bagusandinata' => 'bagusandinata@icloud.com' }
  s.source                = { :git => 'https://github.com/bagusandinata/RHViewStateKit.git', :tag => s.version.to_s }
  s.frameworks            = 'UIKit'
  s.source_files          = 'Source/*.swift'
  s.dependency 'SnapKit', '5.0.1'
end
