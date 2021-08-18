//
//  RollView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/18/21.
//

import SwiftUI

struct RollView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var die1 = 2
    @State private var die2 = 4
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Image(systemName: "die.face.\(die1)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Image(systemName: "die.face.\(die2)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
            Spacer()
            
            Button(action: rollButtonPressed) {
                Text("Roll")
                    .foregroundColor(.black)
                    .frame(width: 100, height: 100)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            
            Spacer()
        }
    }
    
    func rollDice() {
        die1 = Int.random(in: 1...6)
        die2 = Int.random(in: 1...6)
    }
    
    func createAndSaveRollEntity() {
        let roll = Roll(context: moc)
        roll.id = UUID()
        roll.die1 = Int16(die1)
        roll.die2 = Int16(die2)
        roll.date = Date()
        try? moc.save()
    }
    
    func rollButtonPressed() {
        rollDice()
        createAndSaveRollEntity()
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
