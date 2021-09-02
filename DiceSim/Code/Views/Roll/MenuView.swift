//
//  MenuView.swift
//  DiceSim
//
//  Created by Antonio Vega on 8/31/21.
//

import SwiftUI

struct MenuView: View {
    @Binding var mode: Mode
    @Binding var createGame: Bool

    var body: some View {
        VStack(spacing: 10) {
            Button {
                createGame = true
            } label: {
                Text("Game Mode")
            }

            Button {
                mode = .solo
            } label: {
                Text("Solo Mode")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(mode: .constant(.menu), createGame: .constant(false))
    }
}
