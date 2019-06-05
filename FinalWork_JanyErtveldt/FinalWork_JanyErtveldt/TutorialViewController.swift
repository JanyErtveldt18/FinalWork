//
//  TutorialViewController.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 22/05/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var featureScrollView: UIScrollView!
    @IBOutlet weak var featurePageControl: UIPageControl!
    
    let feature1 = ["titel":"Kaart","subtitel":"Start een route naar een instantie via de 'kaarten' app","image":"tutorial_kaart"]
    let feature2 = ["titel":"QR-code","subtitel":"Scan de QR-code en contacteer snel de ouders","image":"tutorial_QR"]
    let feature3 = ["titel":" ","subtitel":" ","image":"Tutorials-screens_geen_account"]
    
     var featureArray = [Dictionary<String,String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.featurePageControl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        featureArray = [feature1,feature2,feature3]
        //Zorgt als je opzij scrollt er een nieuwe pagina volledig geswiped wordt
        featureScrollView.isPagingEnabled = true
        featureScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(featureArray.count), height: 555)
        featureScrollView.showsHorizontalScrollIndicator = false
        
        featureScrollView.delegate = self
        loadFeatures()
        // Do any additional setup after loading the view.
    }
    
    
    func loadFeatures(){
        for(index,feature) in featureArray.enumerated(){
            //Featureview van de klass die je gemaakt hebt
            if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? Featureview {
                featureView.imgTutorial.image = UIImage(named: feature["image"]!)
                featureView.lblTitle.text = feature["titel"]
                featureView.lblSubtitle.text = feature["subtitel"]
              //  featureView.featureSubtitel.text = feature["subtitel"]
                
                //                featureView.btnKiesDezePersoon.tag = index
                //                featureView.btnKiesDezePersoon.addTarget(self, action: #selector(ViewController.persoonKiezen(sender:)), for: . touchUpInside)
                
                featureScrollView.addSubview(featureView)
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        featurePageControl.currentPage = Int(page)
        
    }

}
