//  ActorCellView.swift
//  SD_Movies
//  Created by Miguel Gallego on 6/11/25.
import SwiftUI

struct ActorCellView: View {
    
    let actor: Actor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(actor.name).bold()
            Text(actor.movies.map { $0.title }, format: .list(type: .and))  // IDLT "and" is a bad idea for movie titles
                .font(.caption)
        }
    }
}

#Preview {
    NavigationStack {
        let _ = PreVw.insertSampleData()
        ActorCellView(actor: PreVw.actors[0])
            .border(.red)
    }
}
