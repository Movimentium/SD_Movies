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
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                TextField("Title", text: $title)
                TextField("Year", value: $year, format: .number)
            }
            .onAppear {
                title = movie.title
                year = movie.year
            }
            
            Form {
                Button("Update") {
                    update(movie: movie)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
            }
            
            ForEach(0 ..< 4) { _ in
                Color(.systemGray6)
                    .ignoresSafeArea()
            }
        }
        .navigationTitle("Update Movie")
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

// WTF is this innecessary shit???
struct MovieDetailContainerScreen: View {
    
    @Environment(\.modelContext) private var modelCtx
    @State private var movie: Movie?
    
    var body: some View {
        ZStack {
            if let movie {
                MovieDetailScreen(movie: movie)
            }
        }
        .onAppear {
            movie = Movie(title: "Spiderman", year: 2023)
            modelCtx.insert(movie!)
        }
    }
}


#Preview {
    MovieDetailContainerScreen()
        .modelContainer(for: Movie.self)
}
