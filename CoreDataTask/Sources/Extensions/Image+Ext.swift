//
//  Image+Ext.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 13.09.2022.
//

import UIKit

extension UIImage {
    func scaleImageSize(imageSize: CGSize) -> UIImage {
        let ratioWidth = imageSize.width / size.width
        let ratioHeight = imageSize.height / size.height
        
        let scaleFactor = min(ratioWidth, ratioHeight)
        
        let scaledImageSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        let render = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let scaledImage = render.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        
        return scaledImage
    }
}
