//
//  SentMemesTableViewController.swift
//  Meme Me 2.0
//
//  Created by Mohammed ALZAHRANI on 11/28/18.
//  Copyright © 2018 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    @IBOutlet var memesTableView: UITableView!
    var memes: [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sent Mems"
    }
    @IBAction func newMeme(_ sender: Any) {
        let memeEditorVC: MemeEditorViewController
        memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorViewController
        present(memeEditorVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memesTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath)
        let meme = memes[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        cell.imageView?.image = meme.memedImage
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MemseDetailViewController") as! SentMemseDetailViewController
        let meme = memes[indexPath.row]
        detailVC.meme = meme
        navigationController?.pushViewController(detailVC, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.deleteMeme(index: indexPath.row)
            self.memesTableView.reloadData()
        }
    }

}
