//
//  SentMemesCollectionViewController.swift
//  Meme Me 2.0
//
//  Created by Mohammed ALZAHRANI on 11/28/18.
//  Copyright © 2018 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit


class SentMemesCollectionViewController: UICollectionViewController {
    // MARK: - outlets
    @IBOutlet var memesCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sent Mems"
        configureCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.memesCollectionView.reloadData()
    }
    // create new meme
    @IBAction func newMeme(_ sender: Any) {
        let memeEditorVC: MemeEditorViewController
        memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorViewController
        present(memeEditorVC, animated: true, completion: nil)
    }
    // configure the flow layout for the cell
    func configureCell() {
        let space:CGFloat = 4.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        let itemHight = (view.frame.size.height - 150.0) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: itemHight)
    }

    // MARK: UICollectionView Delegats

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

}
