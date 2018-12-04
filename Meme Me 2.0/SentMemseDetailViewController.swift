//
//  SentMemseDetailViewController.swift
//  Meme Me 2.0
//
//  Created by Mohammed ALZAHRANI on 11/28/18.
//  Copyright © 2018 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit

class SentMemseDetailViewController: UIViewController {
    var meme: Meme!
    var memeIndex: Int!
    @IBOutlet weak var memedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memedImageView.image = meme.memedImage
    }
    override func viewWillAppear(_ animated: Bool) {
        self.memedImageView.image = meme.memedImage
    }
    @IBAction func editMeme(_ sender: Any) {
        let memeEditorVC: MemeEditorViewController
        memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorViewController
        memeEditorVC.meme = self.meme
        memeEditorVC.memeIndex = self.memeIndex
        present(memeEditorVC, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
