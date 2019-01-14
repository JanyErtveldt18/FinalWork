//
//  ViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 10/01/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        return(true)
    }


}

