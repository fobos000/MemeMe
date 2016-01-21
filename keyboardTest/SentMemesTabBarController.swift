//
//  SentMemesTabBarController.swift
//  MemeMe
//
//  Created by Ostap Horbach on 1/8/16.
//  Copyright © 2016 Ostap Horbach. All rights reserved.
//

import UIKit

class SentMemesTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let leftItems = selectedViewController?.navigationItem.leftBarButtonItems {
            navigationItem.leftBarButtonItems = leftItems
        }
    }
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue) {
        
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if let leftItems = viewController.navigationItem.leftBarButtonItems {
            navigationItem.leftBarButtonItems = leftItems
        }
    }
    
}
