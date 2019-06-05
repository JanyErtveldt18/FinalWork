//
//  Politiekantoren.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 02/04/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//

import Foundation

class Politiekantoor {
    
    var id: String?
    var name: String?
    var adres: String?
    var latitude: Double?
    var longitude: Double?
    
    init(id:String?, name: String?, adres: String?,latitude: Double?, longitude: Double?){
        self.id = id
        self.name = name
        self.adres = adres
        self.latitude = latitude
        self.longitude = longitude
    }
}
