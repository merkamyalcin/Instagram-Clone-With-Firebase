//
//  SecondViewController.swift
//  Instagram Clone Parse
//
//  Created by Murat Erkam Yalçın on 24.08.2017.
//  Copyright © 2017 Murat Erkam Yalçın. All rights reserved.
//

import UIKit
import Parse

class uploadVC: UIViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var textViewPost: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textViewPost.delegate = self
        
        let myColor : UIColor = UIColor.lightGray
       
        textViewPost.layer.borderColor = myColor.cgColor
        textViewPost.layer.borderWidth = 1.0
        textViewPost.layer.cornerRadius = 8
        
        textViewPost.text = "Ne düşünüyorsun?."
        textViewPost.textColor = UIColor.lightGray
        
        
        imageViewPost.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.choosePhoto))
        imageViewPost.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func choosePhoto(){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         imageViewPost.image = info[UIImagePickerControllerEditedImage] as? UIImage
         self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        let object = PFObject(className: "Posts")
        
        let data = UIImageJPEGRepresentation(imageViewPost.image!, 0.5)
        
        let pfImage = PFFile(name: "image.jpg", data: data!)
        
        object["postimage"] = pfImage
        object["postcomment"] = textViewPost.text
        object["postowner"] = PFUser.current()!.username!
        
        let uuid = UUID().uuidString
        
        object["postuuid"] = "\(uuid) \(PFUser.current()!.username)"
        
        object.saveInBackground { (success, error) in
            if error != nil {
                
                let alert = UIAlertController(title: "Bir Hata Oluştu", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                print("Oldu")
                self.imageViewPost.image = UIImage(named: "selectPicture.png")
                self.textViewPost.text = ""
                self.tabBarController?.selectedIndex = 0
                
                
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textViewPost.textColor == UIColor.lightGray{
            textViewPost.text = nil
            textViewPost.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textViewPost.text.isEmpty{
            textViewPost.text = "Ne düşünüyorsun?."
            textViewPost.textColor = UIColor.lightGray
            
        }
        
    }
    //Biryere tıklayınca kapatmak.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    
}

