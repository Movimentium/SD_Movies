//  MovieDetailScreen.swift
//  SD_Movies
//  Created by Miguel Gallego on 2/11/25.
import SwiftUI
import SwiftData

struct MovieDetailScreen: View {
    
    let movie: Movie
    @Environment(\.modelContext) private var modelCtx
    @State private var title: String = ""
    @State private var year: Int?
    @State private var showReviewScreen = false
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                TextField("Title", text: $title)
                TextField("Year", value: $year, format: .number)
                Button("Update") {
                    update(movie: movie)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                
                Section("Reviews") {
                    Button {
                        showReviewScreen = true
                    } label: {
                        Image(systemName: "plus")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    if movie.reviews.isEmpty {
                        ContentUnavailableView {
                            Text("No reviews")
                        }
                    } else {
                        ReviewListView(movie: movie)
                    }
                }
                
                Section("Actors") {
                    if movie.actors.isEmpty {
                        ContentUnavailableView {
                            Text("No actors")
                        }
                    } else {
                        List(movie.actors) { actor in
                            ActorCellView(actor: actor)
                        }
                    }
                }
            }
            .onAppear {
                title = movie.title
                year = movie.year
            }
        }
        .navigationTitle("Update Movie")
        .sheet(isPresented: $showReviewScreen) {
            NavigationStack {
                AddReviewScreen(movie: movie)
            }
        }
    }
    
    // MARK: - Logic
    private func update(movie: Movie) {
        guard let year else {
            // TODO: show msg "Year field can not be empty"
            return
        }
        movie.title = title
        movie.year = year
        do {
            try modelCtx.save()
            print(Self.self, #function, "OK")
            dump(movie)
        } catch {
            print(error.localizedDescription);  print(error)
        }
    }
}


#Preview {

    NavigationStack {
        // Comment or Discomment     
        let _ = PreVw.insertSampleData()
        
        MovieDetailScreen(movie: PreVw.movies.last!)
            .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}
