//
//  AvatarImagePicker.swift
//  AvatarImagePickerDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/8/19.
//  Copyright © 2019 Janlionly<jan_ron@qq.com>. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    fileprivate static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

open class AuthSettings: NSObject {
    public static func authCamera(message: String, completion: @escaping ()->Void) -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion()
            return true
        case .denied:
            DispatchQueue.main.async {
                presentAlert(message: message)
            }
            return false
        case .restricted:
            return false
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted {
                    completion()
                }
            }
        default:
            return false
        }
        return false
    }
    
    public static func authPhotoLibrary(message: String, completion: @escaping ()->Void) -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion()
            return true
        case .denied:
            DispatchQueue.main.async {
                presentAlert(message: message)
            }
            return false
        case .restricted:
            return false
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    completion()
                }
            }
            return true
        default:
            return false
        }
    }
    
    static func presentAlert(message: String) {
        let alertCtrl = UIAlertController(title: NSLocalizedString("Need to Authorize", comment: ""), message: message, preferredStyle: .alert)
        alertCtrl.addAction(UIAlertAction(title: NSLocalizedString("Go", comment: ""), style: .default, handler: { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        }))
        alertCtrl.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        guard let window = UIApplication.shared.windows.first else {
            print("Get window failed")
            return
        }
        window.visibleViewController?.present(alertCtrl, animated: true, completion: nil)
    }
}

open class AvatarImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private static var sharedInstance: AvatarImagePicker? = nil
    private var imagePicker: UIImagePickerController!
    private var selected: ((UIImage)->Void)!
    private var cancel:(()->Void)?
    
    private override init(){}
    
    deinit {
        #if DEBUG
        print("\(AvatarImagePicker.self) deinit")
        #endif
    }
    
    public enum SourceType {
        case photoLibrary
        case camera
        case customAction
    }
    /// default both photolibrary and camera
    public var sourceTypes: Set<SourceType> = [.photoLibrary, .camera]
    public var presentStyle: UIModalPresentationStyle = .fullScreen
    public var dismissAnimated: Bool = true
    public var customActions: [String: ()->Void] = [:]
    
    public static var instance: AvatarImagePicker {
        if sharedInstance == nil {
            sharedInstance = AvatarImagePicker()
        }
        return sharedInstance!
    }
    
    // Objective-C version for instance
    @objc public class func avatarImagePicker() -> AvatarImagePicker {
        if sharedInstance == nil {
            sharedInstance = AvatarImagePicker()
        }
        return sharedInstance!
    }
    
    @objc open func present(allowsEditing: Bool, selected: @escaping (UIImage)->Void, cancel: (()->Void)?) {
        autoreleasepool {
            imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = presentStyle
            imagePicker.allowsEditing = allowsEditing
            imagePicker.delegate = self
            self.selected = selected
            self.cancel = cancel

            guard let window = UIApplication.shared.windows.first else {
                print("Get window failed")
                return
            }
            
            if sourceTypes.count > 1 {
                let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                if sourceTypes.contains(.photoLibrary) {
                    sheet.addAction(UIAlertAction(title: NSLocalizedString("Photo Library", comment: ""), style: .default, handler: { (_) in
                        self.imagePicker.sourceType = .photoLibrary
                        _ = AuthSettings.authPhotoLibrary(message: NSLocalizedString("Go to settings to authorize photo library", comment: ""), completion: {
                            DispatchQueue.main.async {
                                window.visibleViewController?.present(self.imagePicker, animated: true, completion: nil)
                            }
                        })
                        
                    }))
                }
                
                if sourceTypes.contains(.camera) {
                    sheet.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (_) in
                        self.imagePicker.sourceType = .camera
                        _ = AuthSettings.authCamera(message: NSLocalizedString("Go to settings to authorize camera", comment: ""), completion: {
                            DispatchQueue.main.async {
                                window.visibleViewController?.present(self.imagePicker, animated: true, completion: nil)
                            }
                        })
                    }))
                }

                sheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (_) in
                    cancel?()
                    AvatarImagePicker.sharedInstance = nil
                }))
                
                for (key, value) in customActions {
                    sheet.addAction(UIAlertAction(title: key, style: .default, handler: { (_) in
                        value()
                        AvatarImagePicker.sharedInstance = nil
                    }))
                }
                present(for: sheet)
            } else if let type = sourceTypes.first, type == .camera {
                self.imagePicker.sourceType = .camera
                _ = AuthSettings.authCamera(message: NSLocalizedString("Go to settings to authorize camera", comment: ""), completion: {
                    DispatchQueue.main.async {
                        window.visibleViewController?.present(self.imagePicker, animated: true, completion: nil)
                    }
                })
            } else if let type = sourceTypes.first, type == .photoLibrary {
                self.imagePicker.sourceType = .photoLibrary
                _ = AuthSettings.authPhotoLibrary(message: NSLocalizedString("Go to settings to authorize photo library", comment: ""), completion: {
                    DispatchQueue.main.async {
                        window.visibleViewController?.present(self.imagePicker, animated: true, completion: nil)
                    }
                })
            } else {
                print("ERROR:SourceTypes is empty")
            }

        }
    }
    
    func present(for alertController: UIAlertController) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else {
                print("Get window failed")
                return
            }
            if let popoverPresentationController = alertController.popoverPresentationController, let ctrl = window.visibleViewController {
                popoverPresentationController.sourceView = ctrl.view
                popoverPresentationController.sourceRect = CGRect(x: ctrl.view.bounds.midX, y: ctrl.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
            window.visibleViewController?.present(alertController, animated: true)
        }
    }
    
    // - MARK: Image picker delegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: dismissAnimated) {
            if let image = info[picker.allowsEditing ? .editedImage : .originalImage] as? UIImage {
                DispatchQueue.main.async {
                    self.selected(image)
                }
            } else {
                DispatchQueue.main.async {
                    self.cancel?()
                }
            }
            AvatarImagePicker.sharedInstance = nil
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.async {
            self.cancel?()
        }
        picker.dismiss(animated: dismissAnimated) {
            AvatarImagePicker.sharedInstance = nil
        }
    }
}
