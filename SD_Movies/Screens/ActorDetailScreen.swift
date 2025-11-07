//  ActorDetailScreen.swift
//  SD_Movies
//  Created by Miguel Gallego on 7/11/25.
import SwiftUI

struct ActorDetailScreen: View {
    
    let actor: Actor
    @Environment(\.modelContext) private var modelCtx
    @State private var selectedMovies: Set<Movie> = []
    
    var body: some View {
        VStack {
            MovieSelectionView(selectedMovies: $selectedMovies)
            
        }
        .navigationTitle(actor.name)
        .onAppear {
            selectedMovies = Set(actor.movies)
        }
        .onChange(of: selectedMovies) {
            addMoviesToTheActorAndSaveActor()
        }
    }
    
    private func addMoviesToTheActorAndSaveActor() {
        actor.movies = Array(selectedMovies)
        modelCtx.insert(actor)
    }
}

#Preview {
    NavigationStack {
        ActorDetailScreen(actor: PreVw.actors[0])
    }
}
