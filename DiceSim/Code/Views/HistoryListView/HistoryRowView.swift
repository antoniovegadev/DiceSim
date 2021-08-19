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
    let currDate: Date
    
    var timeRolled : String {
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: roll.date ?? Date(), to: currDate)
        
        let hours = difference.hour ?? 0
        let minutes = difference.minute ?? 0
        let seconds = difference.second ?? 0
        return "\(hours)h \(minutes)m \(seconds)s"
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "die.face.\(roll.die1).fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
                Image(systemName: "die.face.\(roll.die2).fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
                Text("\(roll.die1 + roll.die2)")
                    .font(.title)
//                    .padding()
            }
            
            Spacer()
            
            Text(timeRolled)
        }
    }
}

struct HistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Roll")
        let items = try! context.fetch(request)
        let item = items[0] as! Roll
        
        HistoryRowView(roll: item, currDate: Date())
            .previewLayout(.sizeThatFits)
    }
}
