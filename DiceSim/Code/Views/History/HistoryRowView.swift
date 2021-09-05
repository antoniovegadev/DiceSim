//
//  HistoryRowView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI
import CoreData

struct HistoryRowView: View {
    let roll: Roll
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "die.face.\(roll.die1)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
                Image(systemName: "die.face.\(roll.die2)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }
            
            Spacer()

            Text("\(roll.die1 + roll.die2)")
                .font(.title)
        }
    }
}

struct HistoryRowView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        HistoryRowView(roll: Roll.example)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .previewLayout(.fixed(width: 300, height: 75))

    }
}
