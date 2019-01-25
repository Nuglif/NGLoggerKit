//
//  UIImage+UIColor.swift
//  NGTools
//
//  Created by Werck, Ayrton on 2018-11-05.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import UIKit

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize) {
        let newImage = color.image(size: size)
        if let ciImage = newImage?.ciImage {
            self.init(ciImage: ciImage)
        }
        return nil
    }

    @objc public convenience init?(color: UIColor, andWidth width: Int) {
        self.init(color: color, size: CGSize(width: width, height: 1))
    }

    @objc public static func image(color: UIColor, size: CGSize) -> UIImage? {
        return color.image(size: size)
    }

    @objc public static func image(color: UIColor, andWidth width: Int) -> UIImage? {
        return color.image(size: CGSize(width: width, height: 1))
    }

    @objc public func tintedImage(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        color.setFill()
        let bounds = CGRect(origin: .zero, size: self.size)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return tintedImage
    }
}
