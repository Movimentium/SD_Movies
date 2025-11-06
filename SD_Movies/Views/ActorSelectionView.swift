//  ActorSelectionView.swift
//  SD_Movies
//  Created by Miguel Gallego on 6/11/25.
import SwiftUI
import SwiftData

struct ActorSelectionView: View {
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    @Binding var selectedActors: Set<Actor>
    
    var body: some View {
        List(actors) { actor in
            HStack {
                Image(systemName: selectedActors.contains(actor) ? "checkmark.square" : "square")
                    
                Text(actor.name)
            }
            .onTapGesture { onCheckActor(actor) }
        }
    }
    
    // MARK: - Logic
    func onCheckActor(_ actor: Actor) {
        if !selectedActors.contains(actor) {
            selectedActors.insert(actor)
        } else {
            selectedActors.remove(actor)
        }
    }
}


#Preview {
    NavigationStack {
        ActorSelectionView(selectedActors: .constant(Set(Actor.actors)))
            .modelContainer(Actor.previewContainer)
    }
}
