//
//  MemeEditorViewController.swift
//  Meme Me 2.0
//
//  Created by Mohammed ALZAHRANI on 11/28/18.
//  Copyright © 2018 Mohammed ALZAHRANI. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextFiled: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    var meme: Meme!
    var memeIndex: Int?
    let textDelegate = TextFieldDelegate()
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.memeImageView.image == nil {
            self.shareButton.isEnabled = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        if self.meme == nil {
            configureTextFields(textField: topTextFiled, withText: "TOP")
            configureTextFields(textField: bottomTextField, withText: "BOTTOM")
        }
        else {
            // when the meme editor VC is presented by the details VC
            configureTextFields(textField: topTextFiled, withText: self.meme.topText)
            configureTextFields(textField: bottomTextField, withText: self.meme.bottomText)
            self.memeImageView.image = self.meme.originalImage
            self.shareButton.isEnabled = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    // MARK: - image related methods
    @IBAction func pickAnImage(_ sender: Any) {
        presentImagePickerWith(sourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    @IBAction func takePicture(_ sender: Any) {
        presentImagePickerWith(sourceType: UIImagePickerControllerSourceType.camera)
    }
    @IBAction func shareMemedImage(_ sender: Any) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        /*The code for completionWithItemsHandler is taken from https://stackoverflow.com/questions/39968210/swift-share-with-function-on-completion */
        controller.completionWithItemsHandler = { (activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if completed == true {
                self.saveMeme(index: self.memeIndex)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(controller, animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // image is picked
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            memeImageView.image = image
            self.shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated:true, completion:nil)
    }
    // MARK: - Keyboard related methods
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        //move the view up only for the bottom text
        if self.bottomTextField.isFirstResponder == true {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        // move the view down
        view.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    // MARK: - Meme
    func generateMemedImage() -> UIImage {
        //  Hide toolbar and navbar
        configureToolbars(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Show toolbar and navbar
        configureToolbars(false)
        return memedImage
    }
    func saveMeme(index:Int?) {
        let meme = Meme(topText: self.topTextFiled.text!, bottomText: self.bottomTextField.text!, originalImage: self.memeImageView.image!, memedImage: generateMemedImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if index == nil {
          appDelegate.memes.append(meme)
        }
        else {
            // save the edited meme
            appDelegate.memes[index!] = meme
        }
    }
    // MARK: - Text configuration
    func configureTextFields(textField :UITextField, withText text: String){
        textField.delegate = self.textDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.text = text
    }
    // MARK: - Toolbars configurations
    func configureToolbars(_ isHidden: Bool) {
        self.topToolbar.isHidden = isHidden
        self.bottomToolbar.isHidden = isHidden
    }
}

