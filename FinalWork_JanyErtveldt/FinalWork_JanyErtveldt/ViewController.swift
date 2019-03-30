//
//  ViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 10/01/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswoord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.txtEmail.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmail.resignFirstResponder()
        return(true)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if let emailAdress = txtEmail.text ,
           let password = txtPasswoord.text{
            
            Auth.auth().signIn(withEmail: emailAdress, password: password){ user, error in
                if error == nil && user != nil{
                    print("User ingelogd")
                    print((Auth.auth().currentUser?.uid)!)
                    let userId = (Auth.auth().currentUser?.uid)!
                    
//                    var dict : [String : Any] = ["userid" : userId]
//                   // LocationSingleton.sharedInstance
//                    let db = Firestore.firestore()
//                    let settings = db.settings
//                    settings.areTimestampsInSnapshotsEnabled = true
//                    db.settings = settings
//                    //db.collection("Users").addDocument(data: dict)
//                    db.collection("Users").document(userId).setData(dict)
                    
                    self.loginUser()
                }else{
                    print("User niet ingelogd")
                    print("Error logging in: \(error!.localizedDescription)")
                }
                
            }
        }
    }
    
    func loginUser(){
        print("Stuur user door naar homescreen")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfielViewControllerID") as! UITabBarController
        self.present(vc, animated: true, completion: nil)
    }
    


}
