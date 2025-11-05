//  ActorListView.swift
//  SD_Movies
//  Created by Miguel Gallego on 5/11/25.
import SwiftUI

struct ActorListView: View {
    let actors: [Actor]
    
    var body: some View {
        List(actors) { actor in
            Text(actor.name)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
