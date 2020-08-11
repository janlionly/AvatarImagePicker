# AvatarImagePicker & AuthSettings
<img src="https://media.giphy.com/media/d8cCPuT1hjkNNb2dnT/giphy.gif" width="250" height="541">	&	<img src="https://github.com/janlionly/AvatarImagePicker/blob/master/Resources/AuthSettings.png" width="250" height="541">

[![Version](https://img.shields.io/cocoapods/v/AvatarImagePicker.svg?style=flat)](https://cocoapods.org/pods/AvatarImagePicker)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/AvatarImagePicker.svg?style=flat)](https://github.com/janlionly/AvatarImagePicker/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/AvatarImagePicker.svg?style=flat)](https://github.com/janlionly/AvatarImagePicker)
![Swift](https://img.shields.io/badge/%20in-swift%204.2-orange.svg)

## Description
**AvatarImagePicker** is a photo library and camera Image Picker for iOS  
written in Swift, it's just a single line of code, support for selecting user's avatar by Camera or Photo Library, editing the selected image. Also, it supports auth verification, if camera or photo library was denied, it will alert the user to the settings for opening it. it means to replace for UIImagePickerController. Compatible with both Swift and Objective-C.

## Installation

### CocoaPods
```ruby
pod 'AvatarImagePicker'
```

### Carthage
```ruby
github "janlionly/AvatarImagePicker"
```

### Swift Package Manager
- iOS: Open Xcode, File->Swift Packages, search input **https://github.com/janlionly/AvatarImagePicker.git**, and then select Version Up to Next Major **1.3.0** < .
- Or add dependencies in your `Package.swift`:
```swift
.package(url: "https://github.com/janlionly/AvatarImagePicker.git", .upToNextMajor(from: "1.3.0")),
```

## Usage

**AvatarImagePicker** is presented with an actionsheet for camera and photo library, and then presented an ImagePickerController, optional some properties supports to customize, like **sourceTypes**, **presentStyle** and **dismissAnimated**.<br>

Remember to add **NSCameraUsageDescription** and **NSPhotoLibraryUsageDescription**'s keys for descriptions to your Info.plist

### Swift

```swift
let picker = AvatarImagePicker.instance

// optional: custom properties
picker.dismissAnimated = false // default is true
picker.sourceTypes = [.camera] // default is [.camera, .photoLibrary]
picker.presentStyle = .overFullScreen // default is .fullScreen

// this method includes authorizing for photolibrary and camera.
picker.present(allowsEditing: true, selected: { (image) in
	// selected image
}) {
	// tapped cancel
   } 


// v1.3.2 updated: support to customize actions for sheet
picker.sourceTypes = [.camera, .customAction]
weak var weakSelf = self
picker.customActions = ["Delete": { weakSelf?.imageView.image = nil }]


// or you can call only auth photolibrary and camera, it will alert the user to go to settings if the photolibrary or camera was denied.
let isAuthSuccess = AuthSettings.authPhotoLibrary(message: "auth photolibrary to get your avatar") {
  print("auth success")
  // go to present image picker controller(photo library), customize your operation here.
}
_ = AuthSettings.authCamera(message: "auth camera to get your avatar") {
  print("auth success")
  // go to present image picker controller(camera), customize your operation here.
}
```

### Objective-C

```objc
[[AvatarImagePicker avatarImagePicker] presentWithAllowsEditing:YES selected:^(UIImage * _Nonnull image) {
        // selected image
    } cancel:^{
        // tapped cancel
    }];
```

## Requirements

- iOS 9.0+
- Swift 4.2 to 5.2

## Author

Visit my github: [janlionly](https://github.com/janlionly)<br>
Contact with me by email: janlionly@gmail.com

## Contribute

I would love you to contribute to **AvatarImagePicker**

## License

**AvatarImagePicker** is available under the MIT license. See the [LICENSE](https://github.com/janlionly/AvatarImagePicker/blob/master/LICENSE) file for more info.
