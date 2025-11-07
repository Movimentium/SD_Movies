//  ReviewListView.swift
//  SD_Movies
//  Created by Miguel Gallego on 4/11/25.
import SwiftUI

struct ReviewListView: View {
    let movie: Movie
    
    @Environment(\.modelContext) private var modelCtx
    
    var body: some View {
        List {
            ForEach(movie.reviews) { review in
                VStack(alignment: .leading, spacing: 2) {
                    Text(review.subject).bold()
                    Text(review.body).font(.subheadline)
                }
            }
            .onDelete(perform: deleteReview)
        }
    }
    
    // MARK: - Logic
    private func deleteReview(indexSet: IndexSet) {
        indexSet.forEach { idx in
            let reviewToDelete = movie.reviews[idx]
            modelCtx.delete(reviewToDelete) // From the DB
            movie.reviews.remove(at: idx)   // From the Movie object
            do {
                try modelCtx.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        // Comment or Discomment if you want to see reviews
        let _ = { PreVw.movies.first!.reviews = PreVw.reviews }()
        
        ReviewListView(movie: PreVw.movies.first!)
    }
}
