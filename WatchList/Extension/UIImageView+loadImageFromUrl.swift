//
//  UIImageView+loadImageFromUrl.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 24/03/23.
//

import UIKit
import SkeletonView

extension UIImageView {
    func loadImageFromUrl(_ url: String?, defaultImage: UIImage?) {
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
        let getImageService = GetImageService()
        
        getImageService.getImage(of: url) { resultImage, errorMessage in
            var selfImage: UIImage?
            
            if let resultImage = resultImage {
                selfImage = resultImage
            } else if let errorMessage = errorMessage {
                print(errorMessage)
                selfImage = defaultImage
            }
            
            DispatchQueue.main.async {
                self.image = selfImage
                self.stopSkeletonAnimation()
                self.hideSkeleton()
            }
        }
    }
}
