//  Actor.swift
//  SD_Movies
//  Created by Miguel Gallego on 5/11/25.
import Foundation
import SwiftData

@Model
final class Actor {
    var name: String
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}
