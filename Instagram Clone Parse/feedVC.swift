//
//  FirstViewController.swift
//  Instagram Clone Parse
//
//  Created by Murat Erkam Yalçın on 24.08.2017.
//  Copyright © 2017 Murat Erkam Yalçın. All rights reserved.
//

import UIKit
import Parse

class feedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUuidArray = [String]()
    var postImageArray = [PFFile]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }

    func getData(){
        
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")//Düzenleme tarihine göre alıyoruz
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                
                let alert = UIAlertController(title: "Veriler Yüklenemedi.", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                
                self.postUuidArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.postCommentArray.removeAll(keepingCapacity: false)
                
                for object in objects!{
                    
                    self.postOwnerArray.append(object.object(forKey: "postowner") as! String)
                    self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                    self.postUuidArray.append(object.object(forKey: "postuuid") as! String)
                    self.postImageArray.append(object.object(forKey: "postimage") as! PFFile)
                    
                    
                }
                
                
                
                
            }
            self.tableView.reloadData()
        }
        
        
        
    }
    
    @IBAction func logoutClick(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if error != nil{
                
                let alert = UIAlertController(title: "Çıkış Yapılamadı", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
                
            }
            else {
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                
                let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signIn") as! signInVC
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
               
                delegate.window?.rootViewController = signIn
                delegate.rememberLogin()
                
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        cell.usernameLabel.text = postOwnerArray[indexPath.row]
        cell.postCommentText.text = postCommentArray[indexPath.row]
        cell.uuidLabel.text = postUuidArray[indexPath.row]
        
        
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil{
                
                let alert = UIAlertController(title: "Bir Hata Oluştu.", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                cell.postImage.image = UIImage(data: data!)
                
            }
        }
        
        return cell
    }
    

}

