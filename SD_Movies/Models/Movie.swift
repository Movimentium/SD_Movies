//  Movie.swift
//  SD_Movies
//  Created by Miguel Gallego on 1/11/25.
import Foundation
import SwiftData

@Model
final class Movie {
    var title: String
    var year: Int
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}
