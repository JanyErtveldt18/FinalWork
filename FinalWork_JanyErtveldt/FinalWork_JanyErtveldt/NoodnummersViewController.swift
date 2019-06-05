//
//  NoodnummersViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 23/02/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit

class NoodnummersViewController: UIViewController {

    @IBOutlet weak var btn101: UIButton!
    @IBOutlet weak var btnBrandweer: UIButton!
    @IBOutlet weak var btnAlgemeen: UIButton!
    @IBOutlet weak var btnChildFocus: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn101.layer.cornerRadius = 10.0
        btnBrandweer.layer.cornerRadius = 10.0
        btnAlgemeen.layer.cornerRadius = 10.0
        btnChildFocus.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    @IBAction func MakeACallToPolitie(_ sender: Any) {
        let url:NSURL = NSURL(string: "tel://101")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func MakeACallToBrandweer(_ sender: Any) {
        let url:NSURL = NSURL(string: "tel://112")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    @IBAction func MakeACallToAlgemeen(_ sender: Any) {
        let url:NSURL = NSURL(string: "tel://112")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func MakeACallToChildFocus(_ sender: Any) {
        let url:NSURL = NSURL(string: "tel://024754411")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
