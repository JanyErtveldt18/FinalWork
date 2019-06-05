//
//  Politiekantoor_Annotation.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 02/04/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import MapKit

class Politiekantoor_Annotation: NSObject, MKAnnotation {
    
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String?,subtitle:String?,coordinate: CLLocationCoordinate2D){
        //In de dataset gaat dit de beschrijving zijn, daar staat de naam in
        self.title = title
        self.subtitle = subtitle
        //In de dataset is dit geografische_coordinaten
        self.coordinate = coordinate
    }
}

