//
//  ContentView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("darkMode") var isDark : Bool = false
    @AppStorage("maxTurn") var maxTurn : Int = 6
    @State var hasUser : Bool = false
    @State var userName : String = ""
    @State var highScore : Int = 0
    @State var game : Game = Game()
    @State var userList : [String : Int] = UserDefaults.standard.object(forKey: "users") as? [String : Int] ?? [:]
    
    
    
    var body: some View {
        
        
        ZStack {
            NavigationStack() {
                VStack {
                    // Logo
                    HStack{
                        if(isDark){
                            Image("dice_logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 350)
                                .colorInvert()
                        }else {
                            Image("dice_logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 350)
                        }
                
                        VStack (alignment: .leading) {
                            Text("FARKLE")
                                .font(.custom("Supfun", size: 50))
                                .foregroundColor(Color("dark"))
                            Text("SOLO")
                                .font(.custom("Supfun", size: 50))
                                .foregroundColor(Color("dark"))
                                .frame( alignment: .leading)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    // NavLink
                    VStack {
                        Text("Username: \(userName)")
                            .font(.custom("Supfun", size: 30))
                            .foregroundColor(Color("dark"))
                        Text("Highscore: \(highScore)")
                            .font(.custom("Supfun", size: 30))
                            .foregroundColor(Color("dark"))
                        NavigationLink {
                            GameView(maxTurn: maxTurn, userName: userName, game: $game, highScore: $highScore)
                            
                        } label: {
                            MainMenuButton(textLabel: "CONTINUE", disabled: !game.hasStart)
                        }.disabled(!game.hasStart)
                        
                        
                        NavigationLink {
                            GameView(maxTurn: maxTurn, userName: userName, game: $game, highScore: $highScore)
                        } label: {
                            MainMenuButton(textLabel: "NEW GAME", disabled: false)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            game = Game()
                        })
                        
                        NavigationLink {
                            LeaderboardView()
                        } label: {
                            MainMenuButton(textLabel: "LEADERBOARD", disabled: false)
                        }
                        
                        NavigationLink {
                            SettingView(isDark: $isDark, maxTurn: $maxTurn)
                        } label: {
                            MainMenuButton(textLabel: "SETTING", disabled: false)
                        }
                        
                        Button {
                            
                        } label: {
                            MainMenuButton(textLabel: "HOW TO PLAY", disabled: false)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                }
            }
            
            if(!hasUser){
                UserNameModal(userName: $userName) {
                    
                    if(userName != ""){
                        
                        if((userList[userName] == nil)){
                            highScore = 0
                            userList[userName] = 0
                            UserDefaults.standard.set(userList, forKey: "users")
                        }
                        let loaded = loadGame(userName: userName)
                        if(loaded != nil){
                            game = loaded!
                            highScore = getHighScore(userName: userName)
                        }
                        
                        hasUser = true
                    }
                }
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
