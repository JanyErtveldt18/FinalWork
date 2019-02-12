//
//  KaartViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 12/02/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit

class KaartViewController: UIViewController {
    @IBOutlet weak var lblMeegekregenQRcode: UILabel!
    
    var meegekregenCode = String("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMeegekregenQRcode.text = meegekregenCode
        // Do any additional setup after loading the view.
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
