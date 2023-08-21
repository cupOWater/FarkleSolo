//
//  GameView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    
    let maxTurn : Int
    @State var userName : String
    @State var isPaused = false
    @Binding var game : Game
    @Binding var highScore : Int
    @State var isRolling : CGFloat = 0
    
    let animation = Animation.default.repeatCount(5).speed(10)
    
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                    Button {
                        isPaused = true
                    } label: {
                        Image(systemName: "line.3.horizontal.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 35)
                            .foregroundColor(Color("dark"))
                            
                    }.padding(.horizontal, 30)
                }
                Spacer()
            }
            VStack {
                
                Text("Stage \(String(game.stage))")
                    .font(.custom("Supfun", size: 35))
                
                HStack{
                    Text("Turn: ")
                        .font(.custom("Supfun", size: 30))
                    Text("\(game.turnCounter > game.maxTurn ? String(game.maxTurn) : String(game.turnCounter)) / \(String(game.maxTurn))")
                        .font(.custom("Supfun", size: 30))
                }
                HStack{
                    Text("Required Score: ")
                        .font(.custom("Supfun", size: 30))
                    Text(String(game.neededScore))
                        .font(.custom("Supfun", size: 30))
                }
                HStack{
                    Text("Total Score: ")
                        .font(.custom("Supfun", size: 25))
                    Text(String(game.totalScore))
                        .font(.custom("Supfun", size: 25))
                }
                HStack{
                    Text("Round Score: ")
                        .font(.custom("Supfun", size: 25))
                    Text(String(game.turnScore))
                        .font(.custom("Supfun", size: 25))
                }
                
                VStack{
                    ForEach(0..<3) { index in
                        let idxLeft = index * 2
                        let idxRight = index * 2 + 1
                        HStack{
                            Spacer()
                            DiceButton(game: $game, index: idxLeft)
                                .offset(x: !game.selected[idxLeft] ? isRolling : 0)
                            
                            Spacer()
                            
                            DiceButton(game: $game, index: idxRight)
                                .offset(x: !game.selected[idxRight] ? isRolling : 0)
                            
                            Spacer()
                        }.padding(5)
                    }
                }
                
                
                HStack {
                    Button {
                        game.canScore = false
                        game.confirmHand()
                        game.canRoll = true
                        
                        saveGame(userName: userName, game: game)
                    } label: {
                        MainMenuButton(textLabel: "Select", disabled: !game.canScore, width: 150, textColor: .white, backgroundColor: .blue)
                    }.disabled(!game.canScore)

                    Button {
                        if !game.canContinue{
                            game.nextTurn()
                        }
                        
                        game.hasStart = true
                        game.deSelectUnused()
                        let usedAll = game.checkUsedAll()
                        if usedAll {
                            game.resetUsed()
                            game.resetSelect()
                        }
                        
                        game.rollDice()
                        
                        withAnimation(animation){
                            isRolling = -30
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
                            withAnimation(animation){
                                isRolling = 0
                            }
                        }
                        game.checkAvailableMove()
                        if !game.canContinue {
                            game.canRoll = true
                        }else {
                            game.canRoll = false
                        }
                        saveGame(userName: userName, game: game)
                    } label: {
                        MainMenuButton(textLabel: game.canContinue ? "Roll" : "Next Turn", disabled: !game.canRoll, width: 150)
                    }.disabled(!game.canRoll)
                        
                }
                .padding(.vertical, 25)
            }
            .padding(.top, 15)

            if(game.turnCounter > game.maxTurn){
                EndGameModal(score: game.totalScore, neededScore: game.neededScore) {
                    dismiss()
                } nextStage: {
                    game.nextStage()
                }
                .onAppear{
                    if(game.totalScore > getHighScore(userName: userName)){
                        highScore = game.totalScore
                        setHighScore(userName: userName, score: game.totalScore)
                    }
                }
            }
            
            if(isPaused){
                PauseModal(isPaused: $isPaused) {
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            if !game.hasStart {
                game.maxTurn = maxTurn
            }
        }
    }
        
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(maxTurn: 4, userName: "Jill", game: .constant(Game()), highScore: .constant(0))
    }
}
