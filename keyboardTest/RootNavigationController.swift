//
//  RootNavigationController.swift
//  MemeMe
//
//  Created by Ostap Horbach on 1/8/16.
//  Copyright © 2016 Ostap Horbach. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if let visibleViewController = visibleViewController {
            return visibleViewController.supportedInterfaceOrientations()
        } else {
            return UIInterfaceOrientationMask.Portrait
        }
    }
    
}
