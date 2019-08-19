//
//  AvatarImagePicker.swift
//  AvatarImagePickerDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/8/19.
//  Copyright © 2019 Janlionly<jan_ron@qq.com>. All rights reserved.
//

import UIKit

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

class AvatarImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    fileprivate static var sharedInstance: AvatarImagePicker? = nil
    fileprivate var imagePicker: UIImagePickerController!
    fileprivate var selected: ((UIImage)->Void)!
    fileprivate var cancel:(()->Void)?
    
    private override init(){}
    
    deinit {
        #if DEBUG
        print("\(AvatarImagePicker.self) deinit")
        #endif
    }
    
    static var instance: AvatarImagePicker {
        if sharedInstance == nil {
            sharedInstance = AvatarImagePicker()
        }
        return sharedInstance!
    }
    
    func present(_ allowsEditing: Bool = false, selected: @escaping (UIImage)->Void, cancel: (()->Void)?) {
        autoreleasepool {
            imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = allowsEditing
            imagePicker.delegate = self
            self.selected = selected
            self.cancel = cancel
            guard let window = UIApplication.shared.delegate?.window else {
                print("Get window failed")
                return
            }
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: NSLocalizedString("Photo Library", comment: ""), style: .default, handler: { (_) in
                self.imagePicker.sourceType = .photoLibrary
                window?.visibleViewController?.present(self.imagePicker, animated: true, completion: nil)
            }))
            sheet.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (_) in
                self.imagePicker.sourceType = .camera
                window?.visibleViewController?.present(self.imagePicker, animated: true, completion: nil)
            }))
            sheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (_) in
                cancel?()
                AvatarImagePicker.sharedInstance = nil
            }))
            
            window?.visibleViewController?.present(sheet, animated: true, completion: nil)
        }
    }
    
    // - MARK: Image picker delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[picker.allowsEditing ? .editedImage : .originalImage] as? UIImage {
            self.selected(image)
        } else {
            self.cancel?()
        }
        picker.dismiss(animated: true, completion: nil)
        AvatarImagePicker.sharedInstance = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.cancel?()
        picker.dismiss(animated: true, completion: nil)
        AvatarImagePicker.sharedInstance = nil
    }
}
