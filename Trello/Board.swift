//
//  Board.swift
//  Trello
//
//  Created by Events on 11/13/16.
//  Copyright © 2016 Oklahoma Christian. All rights reserved.
//

import UIKit


class Board {
    var name: String = ""
    var description: String = ""
    var id: String = ""
    var lists = [List]()
    
    init(name: String, description: String, id: String) {
        self.name = name
        self.description = description
        self.id = id
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.description = json["desc"].stringValue
        self.id = json["id"].stringValue
    }
}

class List {
    var name: String = ""
    var id: String = ""
    var cards = [Card]()
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
    }
}

class Card {
    var name: String = ""
    var description: String = ""
    var id: String = ""
    var list_id: String = ""
    
    init(name: String, description: String, id: String, list_id: String) {
        self.name = name
        self.description = description
        self.id = id
        self.list_id = list_id
    }
    
    init(json: JSON, list_id: String) {
        self.name = json["name"].stringValue
        self.description = json["desc"].stringValue
        self.id = json["id"].stringValue
        self.list_id = list_id
    }
}