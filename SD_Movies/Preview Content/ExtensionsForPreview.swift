//  ExtensionsForPreview.swift
//  SD_Movies
//  Created by Miguel Gallego on 4/11/25.
import Foundation
import SwiftData

extension Movie {
    static let movies = [
        Movie(title: "Memento", year: 2000),
        Movie(title: "Batman", year: 1989)
    ]
}

extension Review {
    static let reviews = [
        Review(subject: "Great Movie", body: "This is a great movie!"),
        Review(subject: "Not Bad", body: "Not bad, but could be better.")
    ]
}

extension SD_Movies.Actor {
    static let actors = [
        Actor(name: "Carrie-Anne Moss"), Actor(name: "Michael Keaton"),
        Actor(name: "Jack Nicholson"), Actor(name: "Guy Pearce")
    ]
    
    @MainActor
    static let previewContainer = {
        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Actor.self, configurations: modelConfig)
        Actor.actors.forEach { container.mainContext.insert($0) }
        return container
    }()
}
