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
        AvatarImagePicker.instance.present(true, selected: { (image) in
            self.imageView.image = image
        }) {
            print("Tap cancel")
        }
    }
}

