//
//  util.swift
//  TodoList
//
//  Created by Adam Lee on 2021/8/5.
//

import Foundation
import UIKit

//改變icon尺寸
func resizeImage(image: UIImage, width: CGFloat) -> UIImage {
        let size = CGSize(width: width, height:
            image.size.height * width / image.size.width)
    let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image { (context) in
            image.draw(in: renderer.format.bounds)
        }
        return newImage
}
