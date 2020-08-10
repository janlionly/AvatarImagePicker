//
//  ViewController.swift
//  AvatarImagePickerDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/8/19.
//  Copyright © 2019 Janlionly<jan_ron@qq.com>. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    // Instruction: add <NSCameraUsageDescription> and <NSPhotoLibraryUsageDescription>'s descriptions to your Info.plist
    // - MARK: Actions
    
    @IBAction func imageViewTapped(_ sender: Any) {
        let picker = AvatarImagePicker.instance
        picker.sourceTypes = [.camera, .customAction]
        weak var weakSelf = self
        picker.customActions = ["Delete": { weakSelf?.imageView.image = nil }]
        
        picker.present(allowsEditing: true, selected: { (image) in
            self.imageView.image = image
        }) {
            print("Tap cancel")
        }
//        _ = AuthSettings.authPhotoLibrary(message: "auth photolibrary to get your avatar") {
//            print("auth success")
//        }
        
//        _ = AuthSettings.authCamera(message: "auth photolibrary to get your avatar") {
//            print("auth success")
//        }
    }
}

