//
//  AvatarImageView.swift
//  AvatarImagePickerDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/10/16.
//  Copyright © 2019 Janlionly<jan_ron@qq.com>. All rights reserved.
//

import UIKit
import YYWebImage

extension UIColor {
    static var grayBackgroundColor: UIColor {
        return UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }
}

open class AvatarImageView: UIImageView {
    private let indicatorTag: Int = 487292739
    
    @objc open var isRound: Bool = false {
        didSet {
            updateRadius()
        }
    }
    @objc open var defaultImage: UIImage? = nil
    
    @objc open var indicatorColor: UIColor = UIColor.clear {
        didSet {
            updateIndicator()
        }
    }
    
    @objc open var imageDidLoadClosure: ((UIImage?)->Void)? = nil
    
    @objc open var url: String? {
        didSet {
            guard let l = url else {
                return
            }
            indicator?.startAnimating()
            yy_setImage(with: URL(string: l), placeholder: defaultImage, options: .allowBackgroundTask) { [weak self] (image, _, _, _, err) in
                self?.indicator?.stopAnimating()
                if err == nil {
                    self?.backgroundColor = .clear
                    self?.imageDidLoadClosure?(image)
                }
            }
        }
    }
    
    @objc open var tapClosure: (()->Void)? {
        didSet {
            isUserInteractionEnabled = tapClosure != nil
        }
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        updateRadius()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        updateRadius()
    }
    
    
    override open var bounds: CGRect {
        didSet {
            updateRadius()
        }
    }
    
    override open var frame: CGRect {
        didSet {
            updateRadius()
        }
    }
    
    private func initUI() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.grayBackgroundColor.cgColor
        contentMode = .scaleAspectFill
        backgroundColor = .grayBackgroundColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(tap)
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.frame = CGRect(x: frame.size.width/2 - 10, y: frame.size.height/2 - 10, width: 20, height: 20)
        indicator.hidesWhenStopped = true
        indicator.tag = indicatorTag
        self.addSubview(indicator)
    }
    
    private func updateRadius() {
        if isRound {
            layer.cornerRadius = frame.size.width/2
            layer.masksToBounds = true
        }
    }
    
    private var indicator: UIActivityIndicatorView? {
        return viewWithTag(indicatorTag) as? UIActivityIndicatorView
    }
    
    private func updateIndicator() {
        indicator?.color = self.indicatorColor
    }
    
    @objc private func didTap() {
        if let tap = self.tapClosure {
            tap()
        }
    }

}

