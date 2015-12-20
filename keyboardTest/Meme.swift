//
//  Meme.swift
//  keyboardTest
//
//  Created by Ostap Horbach on 12/2/15.
//  Copyright © 2015 Ostap Horbach. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText;
        self.bottomText = bottomText;
        self.originalImage = originalImage;
        self.memedImage = memedImage;
    }
}