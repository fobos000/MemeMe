//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Ostap Horbach on 1/7/16.
//  Copyright © 2016 Ostap Horbach. All rights reserved.
//

import UIKit

var memes: [Meme] {
    get {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.memes
    }
}

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemeCell", forIndexPath: indexPath) as! SentMemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        collectionView!.collectionViewLayout.invalidateLayout()
    }
        
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width / 3
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MemeDetail" {
            if let selectedMemeIndexPath = collectionView?.indexPathsForSelectedItems()?.first {
                let selectedMeme = memes[selectedMemeIndexPath.row]
                let detailViewController = segue.destinationViewController as! MemeDetailViewController
                detailViewController.memeImage = selectedMeme.memedImage
            }
        }
    }
}
