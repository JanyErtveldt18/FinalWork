//
//  ViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 10/01/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswoord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.txtEmail.delegate = self
        self.navigationController?.navigationBar.isHidden = true
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
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Homesceen") as! LoginController
//        self.present(vc,animated: true,completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Homesceen") as! LoginController
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

