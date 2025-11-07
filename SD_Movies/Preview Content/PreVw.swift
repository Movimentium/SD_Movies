//  PreVw.swift
//  SD_Movies
//  Created by Miguel Gallego on 4/11/25.
import Foundation
import SwiftData

final class PreVw {
    
    static let movies = [
        Movie(title: "Batman", year: 1989),
        Movie(title: "Memento", year: 2000)
    ]

    static let reviews = [
        Review(subject: "Great Movie", body: "This is a great movie!"),
        Review(subject: "Not Bad", body: "Not bad, but could be better.")
    ]
    
    static let actors = [
        Actor(name: "Carrie-Anne Moss"),
        Actor(name: "Guy Pearce"),
        Actor(name: "Michael Keaton"),
        Actor(name: "Jack Nicholson")
    ]
    
    @MainActor
    static func insertSampleData(_ modelContext: ModelContext? = nil) {
        var modelCtx: ModelContext
        if let mCtx = modelContext {
            modelCtx = mCtx
        } else {
            modelCtx = Self.previewContainer.mainContext
        }
        Self.movies.last!.reviews = Self.reviews
        Self.movies.last!.actors = [Self.actors[0], Self.actors.last!]
        Self.movies.forEach {
            modelCtx.insert($0)
        }
        modelCtx.insert(Self.actors[1])
        modelCtx.insert(Self.actors[2])
    }
    
    @MainActor
    static let previewContainer = {
        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Actor.self, configurations: modelConfig)
        return container
    }()

}
