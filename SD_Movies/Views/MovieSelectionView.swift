//
//  MovieSelectionView.swift
//  SD_Movies
//
//  Created by Miguel Gallego on 7/11/25.
//

import SwiftUI
import SwiftData

struct MovieSelectionView: View {
    
    @Binding var selectedMovies: Set<Movie>
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    
    var body: some View {
        List(movies) { movie in
            HStack {
                Image(systemName: selectedMovies.contains(movie) ? "checkmark.square": "square")
                    .onTapGesture {
                        if !selectedMovies.contains(movie) {
                            selectedMovies.insert(movie)
                        } else {
                            selectedMovies.remove(movie)
                        }
                    }
                Text(movie.title)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieSelectionView(selectedMovies: .constant(Set(Movie.movies)))
            .modelContainer(Actor.previewContainer)
    }
}
