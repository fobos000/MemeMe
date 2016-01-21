//
//  ViewController.swift
//  keyboardTest
//
//  Created by Ostap Horbach on 11/25/15.
//  Copyright © 2015 Ostap Horbach. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraButtonItem: UIBarButtonItem!
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var actionButton: UIBarButtonItem!

    var meme: Meme?
    
    let topTextPlaceholder = NSLocalizedString("TOP", comment: "")
    let bottomTextPlaceholder = NSLocalizedString("BOTTOM", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButtonItem.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        updateActionButton()
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToMainMenu" {
            
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    override func shouldAutorotate() -> Bool {
        return (UIDevice.currentDevice().orientation.isLandscape && (memeImageView.image?.size.height < memeImageView.image?.size.width)) || (UIDevice.currentDevice().orientation.isPortrait && (memeImageView.image?.size.height > memeImageView.image?.size.width))
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if (memeImageView.image?.size.width > memeImageView.image?.size.height) {
            return [UIInterfaceOrientationMask.LandscapeLeft]
        } else {
            return [UIInterfaceOrientationMask.Portrait]
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        memeImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField == topTextField) {
            textField.text = ""
        } else if (textField == bottomTextField) {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if ((textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) == "") {
            if (textField == topTextField) {
                textField.text = topTextPlaceholder
            } else if (textField == bottomTextField) {
                textField.text = bottomTextPlaceholder
            }
        }
    }
    
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0.0)
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext()!, UIColor.whiteColor().CGColor);
        CGContextFillRect(UIGraphicsGetCurrentContext()!, view.bounds)
        memeView.drawViewHierarchyInRect(memeView.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    func updateActionButton() {
        actionButton.enabled = !(memeImageView.image == nil)
    }
    
    func handleKeyboardNotification(notification: NSNotification) {
        if (topTextField.isFirstResponder()) {
            return
        }
        
        if (notification.name == UIKeyboardWillShowNotification) {
            topConstraint.constant -= getKeyboardHeight(notification)
            bottomConstraint.constant += getKeyboardHeight(notification)
        } else {
            topConstraint.constant += getKeyboardHeight(notification)
            bottomConstraint.constant -= getKeyboardHeight(notification)
        }
        
        let animationCurve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        UIView.animateWithDuration(animationDuration.doubleValue, delay: 0, options: UIViewAnimationOptions(rawValue: animationCurve.unsignedIntegerValue), animations: { () -> Void in
            self.view.layoutSubviews()
            }, completion: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardNotification:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func setOrientaion(orientation: UIInterfaceOrientation) {
        UIDevice.currentDevice().setValue(orientation.rawValue, forKey: "orientation")
    }
    
    func saveMeme() {
        if let meme = self.meme {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.memes.append(meme)
        }
    }
    
    @IBAction func cameraItemTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func albumItemTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareTapped(sender: AnyObject) {
        if let memeImage = memeImageView.image, topText = topTextField.text, bottomText = bottomTextField.text {
            meme = Meme(topText: topText, bottomText: bottomText, originalImage: memeImage, memedImage: generateMemedImage())
            
            let shareItems = [meme!.memedImage]
            let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            activityViewController.excludedActivityTypes = [UIActivityTypePostToWeibo, UIActivityTypePostToFlickr]
            activityViewController.completionWithItemsHandler = {
                (activity, success, items, error) in
                if success {
                    self.saveMeme()
                }
            }
            presentViewController(activityViewController, animated: true, completion: nil)
        }
    }
    
}

