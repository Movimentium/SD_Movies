//  Review.swift
//  SD_Movies
//  Created by Miguel Gallego on 4/11/25.
import Foundation
import SwiftData

@Model
final class Review {
    var subject: String
    var body: String
    var movie: Movie?
    
    init(subject: String, body: String) {
        self.subject = subject
        self.body = body
    }
}
