//
//  UIImageExtension.swift
//  IOS Web View with Native Camera Access
//
//  Created by Bela Brody on 04/02/2017.
//  Copyright © 2017 Brody Media. All rights reserved.
//

import UIKit

extension UIImage {
    func getBase64String(headerSign:Bool = false,imgType:String = "png")->String?{
        
        guard let imageData = UIImagePNGRepresentation(self) else {
            return nil
        }
        var base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0))
        if headerSign {
            base64String = "data:image/\(imgType);base64," + base64String
        }
        return base64String
    }
}

func imageToBase64String(_ image:UIImage,headerSign:Bool = false)->String?{
    
    guard let imageData = UIImagePNGRepresentation(image) else {
        return nil
    }
    var base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0))
    if headerSign {
        base64String = "data:image/png;base64," + base64String
    }
    return base64String
}

func imageToBase64String(_ imageName:String,headerSign:Bool = false)->String?{
    guard let image : UIImage = UIImage(named:imageName) else {
        return nil
    }
    return imageToBase64String(image,headerSign:headerSign)
}

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    } }
