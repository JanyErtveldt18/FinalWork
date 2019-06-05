//
//  Feautureview.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 22/05/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import Foundation
import UIKit

class Featureview: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var imgTutorial: UIImageView!
    @IBOutlet weak var ShadowBoxView: UIView!
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        imgTutorial.clipsToBounds = true
        imgTutorial.layer.cornerRadius = 15
//        // Drawing code
        ShadowBoxView.layer.cornerRadius = 15
        ShadowBoxView.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.75).cgColor
        ShadowBoxView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        ShadowBoxView.layer.shadowRadius = 2.5
        ShadowBoxView.layer.shadowOpacity = 0.45
    }
    
}
