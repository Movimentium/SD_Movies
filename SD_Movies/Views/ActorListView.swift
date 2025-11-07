//  ActorListView.swift
//  SD_Movies
//  Created by Miguel Gallego on 5/11/25.
import SwiftUI

struct ActorListView: View {
    let actors: [Actor]
    
    var body: some View {
        List(actors) { actor in
            NavigationLink(value: actor) {
                Text(actor.name)
            }
        }
        .navigationDestination(for: Actor.self) { actor in
            ActorDetailScreen(actor: actor)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
