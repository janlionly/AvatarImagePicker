Pod::Spec.new do |s|
  s.name             = 'AvatarImagePicker'
  s.version          = '1.2.3'
  s.summary          = 'A single line of code for selecting the optional editing image from Camera or Photo Library.'
 
  s.description      = <<-DESC
AvatarImagePicker is a photo library and camera Image Picker for iOS
written in Swift, it's just a single line of code, support for selecting user's avatar by Camera or Photo Library, editing the selected image. Also, it supports auth verification, if camera or photo library was denied, it will alert the user to the settings for opening it. it means to replace for UIImagePickerController. Compatible with both Swift and Objective-C.
                       DESC
 
  s.homepage         = 'https://github.com/janlionly/AvatarImagePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'janlionly' => 'janlionly@gmail.com' }
  s.source           = { :git => 'https://github.com/janlionly/AvatarImagePicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/janlionly'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.source_files = 'Source/*'
  s.frameworks = 'UIKit', 'AVFoundation', 'Photos'
  s.swift_versions = ['4.2', '5.0']
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
end