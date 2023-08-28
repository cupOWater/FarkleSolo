//
//  GameView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("language") var lang : String = "en"

    // Game state
    let maxTurn : Int
    let userName : String
    @State var isPaused = false
    @Binding var game : Game
    @Binding var highScore : Int
    @State var isRolling : CGFloat = 0
    @State var newHighScore = false
    @State var newAchievement : [String] = []
    
    // Animation for the achievement notification
    @State var achieveOffset : CGFloat = -10
    @State var achieveOpac : CGFloat = 0
    
    // Animation for the shake of the dice
    let animation = Animation.default.repeatCount(5).speed(10)
    
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                    // MARK: Pause button
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
                // MARK: Game stat display
                // Stage number
                Text("\("Stage".localized(lang: lang)) \(String(game.stage))")
                    .font(.custom("coiny-regular", size: 35))
                    .padding(.bottom, -48)
                
                HStack{
                    // Number of turns remaining
                    Text("\("turn".localized(lang: lang)): ")
                        .font(.custom("coiny-regular", size: 30))
                    Text("\(game.turnCounter > game.maxTurn ? String(game.maxTurn) : String(game.turnCounter)) / \(String(game.maxTurn))")
                        .font(.custom("coiny-regular", size: 30))
                }
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding(.bottom, -35)
                
                // Total score and Round score
                HStack{
                    Text("\("Total Score".localized(lang: lang)): ")
                        .font(.custom("coiny-regular", size: 25))
                    Text("\(String(game.totalScore))/\(String(game.neededScore))")
                        .font(.custom("coiny-regular", size: 25))
                }
                .padding(.bottom, -35)
                HStack{
                    Text("\("Round Score".localized(lang: lang)): ")
                        .font(.custom("coiny-regular", size: 25))
                    Text(String(game.turnScore))
                        .font(.custom("coiny-regular", size: 25))
                }
                
                VStack{
                    // Display 6 dice
                    ForEach(0..<3) { index in
                        let idxLeft = index * 2
                        let idxRight = index * 2 + 1
                        HStack{
                            Spacer()
                            DiceButton(game: $game, index: idxLeft)
                                .offset(x: isRolling)
                            
                            Spacer()
                            
                            DiceButton(game: $game, index: idxRight)
                                .offset(x: isRolling)
                            
                            Spacer()
                        }.padding(5)
                    }
                }
                
                // MARK: Play buttons
                // Each time button is pressed, play a sound and save the game
                HStack {
                    // MARK: Select button
                    // Confirm a hand and add the score when pressed
                    // Only available if the Hand is valid
                    Button {
                        playSound(sound: "select2", type: "wav")
                        game.canScore = false
                        game.confirmHand()
                        game.canRoll = true
                        
                        saveGame(userName: userName, game: game)
                    } label: {
                        MainMenuButton(textLabel: "Select", disabled: !game.canScore, width: 150, textColor: .white, backgroundColor: .orange)
                    }.disabled(!game.canScore)

                    
                    // MARK: Roll/ Next turn button
                    // Roll the dice if the game start or if the user has selected the Hand(s)
                    // If no hand is available left, the user can move to the next turn
                    Button {
                        if !game.canContinue{
                            // Check for turn achievements
                            if(game.turnScore >= 500){
                                if (addUserAchievement(userName: userName, achievement: "500pts")){
                                    newAchievement.append("500pts")
                                }
                            }
                            if(game.turnScore >= 2000){
                                if (addUserAchievement(userName: userName, achievement: "2000pts")){
                                    newAchievement.append("2000pts")
                                }
                            }
                            game.nextTurn()
                            
                            if(game.turnCounter > game.maxTurn) {
                                // WHEN NO TURN LEFT:
                                addStatStagePlayed(userName: userName)
                                
                                // If Win
                                if (game.totalScore >= game.neededScore) {
                                    addStatWinStage(userName: userName)
                                }
                                
                                // New High Score
                                if(game.totalScore > getHighScore(userName: userName)){
                                    newHighScore = true
                                    highScore = game.totalScore
                                    setHighScore(userName: userName, score: game.totalScore)
                                }
                            }
                        }
                        
                        game.hasStart = true
                        game.deSelectUnused()
                        
                        // If no dice on table, give player new dice
                        let usedAll = game.checkUsedAll()
                        if usedAll {
                            game.resetUsed()
                            game.resetSelect()
                        }
                        
                        game.rollDice()
                        playSound(sound: "dice", type: "wav")
                        
                        withAnimation(animation){
                            isRolling = -30
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
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

            // MARK: Result Modal
            // If no turn remaining, check game result
            // Total score >= Needed score => Win
            if(game.turnCounter > game.maxTurn){
                EndGameModal(score: game.totalScore, neededScore: game.neededScore, newHighScore: newHighScore) {
                    if(game.totalScore < game.neededScore){
                        game = Game()
                    }
                    dismiss()
                } nextStage: {
                    game.nextStage()
                    newHighScore = false
                    if (game.stage == 2){
                        if (addUserAchievement(userName: userName, achievement: "stage2")){
                            newAchievement.append("stage2")
                        }
                    }
                    
                    if (game.stage == 5){
                        if (addUserAchievement(userName: userName, achievement: "stage5")){
                            newAchievement.append("stage5")
                        }
                    }
                }
                .onAppear{
                    if(game.totalScore >= game.neededScore){
                        playSound(sound: "win", type: "wav")
                    }else {
                        playSound(sound: "lose", type: "wav")
                    }
                }
            }
            
            // MARK: Pause status
            if(isPaused){
                PauseModal(isPaused: $isPaused) {
                    dismiss()
                }
            }
            
            // MARK: Achievement Display
            // While there is an achievement, display the notification
            // After a bit, hide the notification
            if(!newAchievement.isEmpty) {
                VStack {
                    ForEach(newAchievement, id: \.self) { a in
                        AchivementNoti(achievement: a)
                    }
                    
                    Spacer()
                }
                .opacity(achieveOpac)
                .offset(y: achieveOffset)
                .animation(.easeIn(duration: 0.5), value: achieveOffset)
                .onAppear{
                    achieveOffset = 10
                    achieveOpac = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeOut(duration: 0.5)){
                            achieveOffset = -10
                            achieveOpac = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            newAchievement = []
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            if !game.hasStart {
                game.maxTurn = maxTurn
            }
        }
        .onDisappear{
            // Start BG Music again
            playSound(sound: "background", type: "wav", loop: -1)
        }
    }
        
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(maxTurn: 4, userName: "Jill", game: .constant(Game()), highScore: .constant(0))
    }
}
