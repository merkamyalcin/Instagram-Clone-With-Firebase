//
//  signInVC.swift
//  Instagram Clone Parse
//
//  Created by Murat Erkam Yalçın on 24.08.2017.
//  Copyright © 2017 Murat Erkam Yalçın. All rights reserved.
//

import UIKit
import Parse

class signInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
            
        
        
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
            
            PFUser.logInWithUsername(inBackground: emailText.text!, password: passwordText.text!, block: { (user, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Giriş Yapılamadı", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
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
            let alert = UIAlertController(title: "Giriş Yapılamadı", message: "Giriş yapabilmek için lütfen kullanıcı adınızı ve/veya parolanızı giriniz.", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
