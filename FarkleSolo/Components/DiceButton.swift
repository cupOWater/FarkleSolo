//
//  DiceButton.swift
//  FarkleSolo
//
//  Created by MacNCheese on 21/08/2023.
//

import SwiftUI

struct DiceButton: View {
    
    @Binding var game : Game
    let index : Int
    
    var body: some View {
        Button {
            playSound(sound: "select1", type: "wav")
            // change the game selected array when clicked
            game.selected[index].toggle()
            game.canScore = game.getScore(selectedArr: game.getSelected()) > 0 ? true : false
        } label: {
            Image("dice_\(game.rolledDice[index])")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay{
                    if(game.selected[index] && !game.used[index]){
                        RoundedRectangle(cornerRadius: 25)
                        .stroke(.yellow, lineWidth: 10)}
                }
                .opacity(game.used[index] || !game.hasStart ? 0 : 1)
        }
        .disabled(game.used[index] || !game.hasStart)
    }
}

//struct DiceButton_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(maxTurn: 8, userName: "David")
//    }
//}
