//  MovieListScreen.swift
//  SD_Movies
//  Created by Miguel Gallego on 2/11/25.
import SwiftUI
import SwiftData

struct MovieListScreen: View {
    @Environment(\.modelContext) private var modelCtx
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    @State private var isShowingAddMovieScreen = false
    @State private var isShowingAddActorScreen = false
    @State private var actorName = ""
    
    // TODO: review this: pe: 2 taps to add movies...
#if DEBUG
    @State private var isDBwithSampleMovies = false
#endif
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Movies")
                .font(.title).bold()
                .padding(.horizontal)
            MovieListView(movies: movies)
            Text("Actors")
                .font(.title).bold()
                .padding(.horizontal)
            ActorListView(actors: actors)
        }
        .background(Color.secondary.opacity(0.1))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    isShowingAddActorScreen = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    isShowingAddMovieScreen = true
                }
            }
        }
        .sheet(isPresented: $isShowingAddMovieScreen) {
            NavigationStack {
                AddMovieScreen()
            }
        }
        .sheet(isPresented: $isShowingAddActorScreen) {
            Text("Add Actor")
                .font(.largeTitle)
            TextField("Name", text: $actorName)
                .textFieldStyle(.roundedBorder)
                .presentationDetents([.fraction(0.25)])
                .padding()
            Button("Save") {
                saveActor()
                isShowingAddActorScreen = false
            }
            .buttonStyle(.borderedProminent)
        }
#if DEBUG
        .onAppear() {
            if !isDBwithSampleMovies {
                Movie.movies.first!.reviews = Review.reviews
                Movie.movies.forEach { modelCtx.insert($0) }
                try! modelCtx.save()
                isDBwithSampleMovies = true
            }
        }
#endif
        
    }
    
    // MARK: - Logic
    private func saveActor() {
        let newActor = Actor(name: actorName)
        modelCtx.insert(newActor)  // Now M.A. do not use modelCtx.save()
    }
    
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}
