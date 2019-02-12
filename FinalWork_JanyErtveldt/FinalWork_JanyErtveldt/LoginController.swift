//
//  LoginController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 14/01/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class LoginController: UIViewController {
    @IBOutlet weak var testQRcodeLabel: UILabel!
    var testQRcodeScan = String("")

    
    override func viewDidLoad(){
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = false
        
       
        
    }
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        print("User logout")
        try! Auth.auth().signOut()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
