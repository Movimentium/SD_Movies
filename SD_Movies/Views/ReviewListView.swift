//  ReviewListView.swift
//  SD_Movies
//  Created by Miguel Gallego on 4/11/25.
import SwiftUI

struct ReviewListView: View {
    let reviews: [Review]
    
    @Environment(\.modelContext) private var modelCtx
    
    var body: some View {
        List {
            ForEach(reviews) { review in
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
            let reviewToDelete = reviews[idx]
            modelCtx.delete(reviewToDelete)
            do {
                try modelCtx.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ReviewListView(reviews: Review.reviews)
}
