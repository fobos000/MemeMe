//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Ostap Horbach on 1/7/16.
//  Copyright © 2016 Ostap Horbach. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        get {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            return appDelegate.memes
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.layoutSubviews()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeCell", forIndexPath: indexPath) as! SentMemeTableViewCell
        
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        cell.memeLabel.text = meme.topText + " " + meme.bottomText
        
        return cell
    }
    
    @IBAction func editTapped() {
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MemeDetail" {
            if let selectedMemeIndexPath = tableView.indexPathForSelectedRow {
                let selectedMeme = memes[selectedMemeIndexPath.row]
                let detailViewController = segue.destinationViewController as! MemeDetailViewController
                detailViewController.memeImage = selectedMeme.memedImage
            }
        }
    }
}
