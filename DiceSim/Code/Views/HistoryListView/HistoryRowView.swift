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
                .font(.largeTitle)
                .padding()
        }
    }
}

struct HistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Roll")
        let items = try! context.fetch(request)
        let item = items[0] as! Roll
        
        HistoryRowView(roll: item)
            .previewLayout(.sizeThatFits)
    }
}
