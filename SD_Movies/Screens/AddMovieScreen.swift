//  AddMovieScreen.swift
//  SD_Movies
//  Created by Miguel Gallego on 2/11/25.
import SwiftUI
import SwiftData

struct AddMovieScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelCtx
    
    @State private var title: String = ""
    @State private var year: Int?
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    // dismiss
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveMovie()
                }
                .disabled(!isFormValid)
            }
        }
    }
    
    // MARK: - Logic
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace && year != nil
    }
    
    private func saveMovie() {
        guard let year else {
            // TODO: show msg "Year field can not be empty"
            return
        }
        let movie = Movie(title: title, year: year)
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
        AddMovieScreen()
            .navigationTitle("Add Movie")
    }
    .modelContainer(for: [Movie.self])
}
