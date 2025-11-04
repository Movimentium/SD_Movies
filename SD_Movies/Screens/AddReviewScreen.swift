//  AddReviewScreen.swift
//  SD_Movies
//  Created by Miguel Gallego on 4/11/25.
import SwiftUI

struct AddReviewScreen: View {
    let movie: Movie

    @Environment(\.modelContext) private var modelCtx
    @Environment(\.dismiss) private var dismiss
    @State private var subject: String = ""
    @State private var description: String = ""
    
    var body: some View {
        Form {
            TextField("Subject", text: $subject)
            TextField("Description", text: $description)
        }
        .navigationTitle("Review: \(movie.title)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { saveReview() }
                    .disabled(!isFormValid)
            }
        }
    }
    
    
    // MARK: - Logic
    private func saveReview() {
        let review = Review(subject: subject, body: description)  //IDLI
        review.movie = movie
        modelCtx.insert(review)
        do {                               // IDLI: repeated code
            try modelCtx.save()
            movie.reviews?.append(review)  // is this necessary??
        } catch {
            print(error.localizedDescription)
        }
        dismiss()
    }
    
    private var isFormValid: Bool {
        !subject.isEmptyOrWhiteSpace && !description.isEmptyOrWhiteSpace
    }
    
}

#Preview {
    NavigationStack {
        AddReviewScreen(movie: Movie.movies.first!)
            .modelContainer(for: [Movie.self, Review.self])
    }
}
