//
//  Kind.swift
//  FinalWork_JanyErtveldt
//
//  Created by Jany Ertveldt on 19/02/2019.
//  Copyright © 2019 Jany Ertveldt. All rights reserved.
//
import Foundation

class Kind {
    
    var id: String?
    var naamOuder: String?
    var voornaamOuder: String?
    var naamKind: String?
    var voornaamKind: String?
    var beschrijving: String?
    var leeftijd: Int?
    //var url: String?
    
    init(id:String?, naamOuder: String?, voornaamOuder: String?, naamKind: String?, voornaamKind: String?, beschrijving: String?,leeftijd: Int?){
        self.id = id
        self.voornaamOuder = voornaamOuder
        self.naamOuder = naamOuder
        self.voornaamKind = voornaamKind
        self.naamKind = naamKind
        self.beschrijving = beschrijving
        self.leeftijd = leeftijd
        //self.url = url
    }
}
