//
//  HistoryListView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(entity: Roll.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Roll.date, ascending: false)]
    ) var rolls: FetchedResults<Roll>

    @State private var showingDeleteConfirmationAlert = false
    
    var body: some View {
        NavigationView {
            List(rolls) { roll in
                HistoryRowView(roll: roll)
            }
            .navigationBarTitle("History")
            .toolbar {
                Button {
                    showingDeleteConfirmationAlert = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .accentColor(.red)
        .alert(isPresented: $showingDeleteConfirmationAlert) {
            Alert(
                title: Text("Delete History"),
                message: Text("Are you sure you want to delete the current history?"),
                primaryButton: .destructive(Text("Delete"), action: dataController.deleteAll),
                secondaryButton: .cancel()
            )
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        HistoryListView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
