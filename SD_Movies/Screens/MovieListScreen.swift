//  MovieListScreen.swift
//  SD_Movies
//  Created by Miguel Gallego on 2/11/25.
import SwiftUI
import SwiftData

struct MovieListScreen: View {
    //@Query private var movies: [Movie] // without any order or predicate
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @State private var isShowingAddMovieScreen = false
    
    // TODO: review this
    #if DEBUG
    @Environment(\.modelContext) private var modelCtx
    @State private var isDBwithSampleMovies = false
    #endif
    
    var body: some View {
        MovieListView(movies: movies)
            .toolbar {
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
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self])
    }
}
