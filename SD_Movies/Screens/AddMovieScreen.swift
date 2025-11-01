//  AddMovieScreen.swift
//  SD_Movies
//  Created by Miguel Gallego on 2/11/25.
import SwiftUI

struct AddMovieScreen: View {
    
    @State private var title: String = ""
    @State private var year: Int?

    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
        }
     }
}

#Preview {
    AddMovieScreen()
}
