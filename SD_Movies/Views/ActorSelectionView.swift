//  ActorSelectionView.swift
//  SD_Movies
//  Created by Miguel Gallego on 6/11/25.
import SwiftUI
import SwiftData

struct ActorSelectionView: View {
    @Query private var actors: [Actor]
    
    var body: some View {
        List(actors) { actor in
            
            Text(actor.name)
        }
    }
}

