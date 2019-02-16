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
import GeoFire

class LoginController: UIViewController {
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    //    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var profielImage: UIImageView!
    
    var menuShowing = false
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("Viewdidload")
        print(menuShowing)
         self.navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        
   
        self.profielImage.layer.cornerRadius = self.profielImage.frame.size.width / 2;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "HOME"
    }
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        print("User logout")
        try! Auth.auth().signOut()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! ViewController
                self.present(vc,animated: true,completion: nil)
    }
    
    @IBAction func openInfoMenu(_ sender: Any) {
        print("menuShowing")
        print(menuShowing)
        if(menuShowing){
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.tabBarController?.tabBar.isHidden = true
            })
        }else{
            
            leadingConstraint.constant = 375
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = false
            })
            
            
        }
        menuShowing = !menuShowing
    }
    
}
