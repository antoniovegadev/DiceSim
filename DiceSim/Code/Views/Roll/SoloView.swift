//
//  SoloView.swift
//  DiceSim
//
//  Created by Antonio Vega on 9/1/21.
//

import SwiftUI

struct SoloView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var dataController: DataController
    
    @State private var die1 = 2
    @State private var die2 = 4
    @State private var rolling = false
    
    var body: some View {
        VStack {
            Spacer()

            HStack {
                Image(systemName: "die.face.\(die1)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .animation(.linear)

                Image(systemName: "die.face.\(die2)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .animation(.linear)
            }

            Spacer()

            Button {
                rollDice()
            } label: {
                Text("Roll")
            }
            .buttonStyle(AppleButtonStyle(color: .blue))
            .opacity(rolling ? 0.5 : 1.0)
            .allowsHitTesting(!rolling)
            .padding()
        }
    }

    func rollDice() {
        rolling = true

        for i in stride(from: 0.0, to: 1.2, by: 0.1) {
            let gap = i * i * 2
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(gap)) {
                die1 = Int.random(in: 1...6)
                die2 = Int.random(in: 1...6)

                if i >= 1.1 {
                    rolling = false
                    createAndSaveRollEntity()
                }
            }
        }
    }

    func createAndSaveRollEntity() {
        let roll = Roll(context: managedObjectContext)
        roll.id = UUID()
        roll.die1 = Int16(die1)
        roll.die2 = Int16(die2)
        roll.date = Date()
        dataController.save()
    }
}

struct SoloView_Previews: PreviewProvider {
    static var previews: some View {
        SoloView()
    }
}
