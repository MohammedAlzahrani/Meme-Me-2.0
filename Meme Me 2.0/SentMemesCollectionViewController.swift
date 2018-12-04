//
//  SentMemesCollectionViewController.swift
//  Meme Me 2.0
//
//  Created by Mohammed ALZAHRANI on 11/28/18.
//  Copyright © 2018 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class SentMemesCollectionViewController: UICollectionViewController {
    @IBOutlet var memesCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MemeCollectionViewCell")
        let space:CGFloat = 4.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        let itemHight = (view.frame.size.height - 150.0) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: itemHight)
        //UIDevice.current.orientation.isLandscape
        self.navigationItem.title = "Sent Mems"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.memesCollectionView.reloadData()
    }

    @IBAction func newMeme(_ sender: Any) {
        let memeEditorVC: MemeEditorViewController
        memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorViewController
        present(memeEditorVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
    
        // Configure the cell
        cell.memedImage.image = memes[indexPath.row].memedImage
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MemseDetailViewController") as! SentMemseDetailViewController
        let meme = memes[indexPath.row]
        detailVC.meme = meme
        detailVC.memeIndex = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.current.orientation.isLandscape {
//            self.flowLayou
//            print("landscape")
//        } else {
//            print("portrait")
//        }
//    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
