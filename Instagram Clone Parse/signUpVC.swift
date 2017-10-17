//
//  signUpVC.swift
//  Instagram Clone Parse
//
//  Created by Murat Erkam Yalçın on 24.08.2017.
//  Copyright © 2017 Murat Erkam Yalçın. All rights reserved.
//

import UIKit
import Parse

class signUpVC: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nicknameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailTextReply: UITextField!
    @IBOutlet weak var passwordTextReply: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

    @IBAction func signInButtonClick(_ sender: Any) {
       
        if emailText.text == emailTextReply.text && passwordText.text == passwordTextReply.text{
            if emailText.text != "" && passwordText.text != "" && nicknameText.text != ""{
                
                let user = PFUser()
                user.username = nicknameText.text!
                user.email = emailText.text!
                user.password = passwordText.text!
                user.signUpInBackground(block: { (success, error) in
                    
                    if error != nil{
                        let alert = UIAlertController(title: "Bir Hata Oluştu", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else{
                        
                        UserDefaults.standard.set(self.emailText.text, forKey: "username")
                        UserDefaults.standard.synchronize()
                        
                        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        delegate.rememberLogin()
                        
                        
                    }
                    
                })

                
            }
            else {
                
                let alert = UIAlertController(title: "Hata Oluştu", message: "Kayıt olmak için Kullanıcı adı, Email ve Şifre kısımlarını boş bırakmamanız gerekmektedir.", preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        else{
            
            let alert = UIAlertController(title: "Hata Oluştu", message: "Email ve/veya Şifreniz birbirinine uyuşmuyor.", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
