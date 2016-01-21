//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Ostap Horbach on 1/11/16.
//  Copyright © 2016 Ostap Horbach. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImageView: UIImageView!
    
    var memeImage: UIImage? {
        didSet {
            if let memeImageView = memeImageView {
                memeImageView.image = memeImage
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeImageView.image = memeImage
    }
}
