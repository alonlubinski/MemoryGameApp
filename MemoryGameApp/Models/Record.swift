//
//  Record.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/29/21.
//

import Foundation

class Record: Codable {
    var id: String
    var name: String
    var time: Int
    var lng: Double
    var lat: Double
    
    init(id: String, name: String, time: Int, lng: Double, lat: Double){
        self.id = id
        self.name = name
        self.time = time
        self.lng = lng
        self.lat = lat
    }
}
