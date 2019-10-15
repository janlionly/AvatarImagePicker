//
//  ViewController.swift
//  AvatarImagePickerDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/8/19.
//  Copyright © 2019 Janlionly<jan_ron@qq.com>. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: AvatarImageView!
    
    @IBOutlet weak var smallImageView: AvatarImageView!
    // Instruction: add <NSCameraUsageDescription> and <NSPhotoLibraryUsageDescription>'s descriptions to your Info.plist
    // - MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.url = "http://images.xuejuzi.cn/1612/1_161230185104_1.jpg"
        imageView.imageDidLoadClosure = { [weak self] image in
            self?.smallImageView.image = image
        }
        
        imageView.tapClosure = {
            AvatarImagePicker.instance.present(allowsEditing: true, selected: { (image) in
                self.imageView.image = image
            }) {
                print("Tap cancel")
            }
        }
    }
}

