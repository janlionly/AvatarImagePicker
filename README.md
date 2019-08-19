![AvatarImagePicker](https://github.com/janlionly/AvatarImagePicker/blob/master/Resources/AvatarImagePickerPresentation.png =320x)

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/OpalImagePicker.svg?style=flat)](https://github.com/janlionly/AvatarImagePicker/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/ImagePicker.svg?style=flat)](https://github.com/janlionly/AvatarImagePicker)
![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg)

## Description
**AvatarImagePicker** is a photo library and camera Image Picker for iOS  
written in Swift, it's just a single line of code, support for selecting user's avatar by Camera or Photo Library, editing the selected image, it means to replace for UIImagePickerController. Compatible with both Swift and Objective-C.

## Installation

### Carthage
```ruby
platform :ios, '9.0'
github "janlionly/AvatarImagePicker"
```

## Usage

**AvatarImagePicker** is presented a actionsheet for camera and photo library, and then presented a ImagePickerController.<br>

Remember to add **NSCameraUsageDescription** and **NSPhotoLibraryUsageDescription**'s keys for descriptions to your Info.plist

```swift
AvatarImagePicker.instance.present(true, selected: { (image) in
	// selected image
}) {
	// tap cancel
   }
```

## Requirements

- iOS 9.0+
- Swift 4 to 5.0

## Author

Visit my github: [janlionly](https://github.com/janlionly)<br>
Contact with me by email: janlionly@gmail.com

## Contribute

I would love you to contribute to **AvatarImagePicker**

## License

**AvatarImagePicker** is available under the MIT license. See the [LICENSE](https://github.com/janlionly/AvatarImagePicker/blob/master/LICENSE) file for more info.