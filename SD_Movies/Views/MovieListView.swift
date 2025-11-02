//  MovieListView.swift
//  SD_Movies
//  Created by Miguel Gallego on 1/11/25.
import SwiftUI
import SwiftData

struct MovieListView: View {
    
    @Environment(\.modelContext) private var modelCtx
    let movies: [Movie]
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                HStack(alignment: .center, spacing: 20){
                    Text(movie.title)
                    Text(movie.year.description)
                }
            }
            .onDelete(perform: deleteMovie)
        }
    }
    
    // MARK: - Logic
    private func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { idx in
            let movie = movies[idx]
            modelCtx.delete(movie)
            do {
                try modelCtx.save()
            } catch {
                print(error.localizedDescription);  print(error)
            }
        }
    }
    
}

#Preview {
    MovieListView(movies: [])
}
