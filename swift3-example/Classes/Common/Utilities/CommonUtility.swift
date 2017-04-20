//
//  CommonUtility.swift
//  swift3-example
//
//  Created by Quang Co on 3/21/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class CommonUtility {
    static func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!;
    }
    
    static func resizeImage(image: UIImage?, size: CGSize) -> UIImage? {
        if let sourceImage = image {
            var newImage:UIImage = UIImage()
            let imageSize = sourceImage.size
            let width = imageSize.width
            let height = imageSize.height
            
            let targetWidth = size.width
            let targetHeight = size.height
            
            var scaleFactor:CGFloat = 0
            var scaleWidth = targetWidth
            var scaleHeight = targetHeight
            
            var thumbPoint = CGPoint.zero
            if(!size.equalTo(imageSize)){
                let widthFactor = targetWidth / width
                let heightFactor = targetHeight / height;
                
                if widthFactor < heightFactor {
                    scaleFactor = widthFactor
                } else{
                    scaleFactor = heightFactor
                }
                
                scaleWidth = scaleFactor*width
                scaleHeight = scaleFactor*height
                
                if widthFactor < heightFactor {
                    thumbPoint.y = (targetHeight - scaleHeight)*0.5
                } else{
                    thumbPoint.x = (targetWidth - scaleWidth)*0.5
                }
            }
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0);
            
            var thumbRect = CGRect.zero
            thumbRect.origin = thumbPoint
            thumbRect.size.width = scaleWidth
            thumbRect.size.height = scaleHeight
            
            sourceImage.draw(in: thumbRect)
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return newImage
            
        } else{
            return nil
        }
    }
    
    static func resizeImageName(image: String, size: CGSize) -> UIImage? {
        if let sourceImage = UIImage.init(named: image){
            var newImage:UIImage = UIImage()
            let imageSize = sourceImage.size
            let width = imageSize.width
            let height = imageSize.height
            
            let targetWidth = size.width
            let targetHeight = size.height
            
            var scaleFactor:CGFloat = 0
            var scaleWidth = targetWidth
            var scaleHeight = targetHeight
            
            var thumbPoint = CGPoint.zero
            if(!size.equalTo(imageSize)){
                let widthFactor = targetWidth / width
                let heightFactor = targetHeight / height;
                
                if widthFactor < heightFactor {
                    scaleFactor = widthFactor
                } else{
                    scaleFactor = heightFactor
                }
                
                scaleWidth = scaleFactor*width
                scaleHeight = scaleFactor*height
                
                if widthFactor < heightFactor {
                    thumbPoint.y = (targetHeight - scaleHeight)*0.5
                } else{
                    thumbPoint.x = (targetWidth - scaleWidth)*0.5
                }
            }
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0);
            
            var thumbRect = CGRect.zero
            thumbRect.origin = thumbPoint
            thumbRect.size.width = scaleWidth
            thumbRect.size.height = scaleHeight
            
            sourceImage.draw(in: thumbRect)
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return newImage
            
        } else{
            return nil
        }
    }
}
