//
//  HistoryListView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI

struct HistoryListView: View {
    @FetchRequest(entity: Roll.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Roll.date, ascending: false)]
    ) var rolls: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List(rolls) { roll in
                HistoryRowView(roll: roll, currDate: Date())
            }
            .navigationBarTitle("History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        HistoryListView()
            .environment(\.managedObjectContext, context)
    }
}
