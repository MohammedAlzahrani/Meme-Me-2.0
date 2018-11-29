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
    @IBOutlet weak var memedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memedImageView.image = meme.memedImage
    }

}
