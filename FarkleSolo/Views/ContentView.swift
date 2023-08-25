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
    @AppStorage("language") var lang : String = "en"
    @State var hasUser : Bool = false
    
    @State var userName : String = ""
    @State var highScore : Int = 0
    
    @State var game : Game = Game()
    @State var showTutorial : Bool = false
    
    
    
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
                            .font(.custom("coiny-regular", size: 25))
                            .foregroundColor(Color("dark"))
                        Text("Highscore: \(highScore)")
                            .font(.custom("coiny-regular", size: 25))
                            .foregroundColor(Color("dark"))
                        NavigationLink {
                            GameView(maxTurn: maxTurn, userName: userName, game: $game, highScore: $highScore)
                            
                        } label: {
                            MainMenuButton(textLabel: "continue", disabled: !game.hasStart)
                        }.disabled(!game.hasStart)
                        
                        
                        NavigationLink {
                            GameView(maxTurn: maxTurn, userName: userName, game: $game, highScore: $highScore)
                        } label: {
                            MainMenuButton(textLabel: "newGame", disabled: false)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            game = Game()
                        })
                        
                        NavigationLink {
                            LeaderboardView(userName: userName)
                        } label: {
                            MainMenuButton(textLabel: "leaderboard", disabled: false)
                        }
                        
                        NavigationLink {
                            SettingView(isDark: $isDark, maxTurn: $maxTurn, hasUser: $hasUser)
                        } label: {
                            MainMenuButton(textLabel: "setting", disabled: false)
                        }
                        
                        Button {
                            showTutorial.toggle()
                        } label: {
                            MainMenuButton(textLabel: "how2play", disabled: false)
                        }.sheet(isPresented: $showTutorial) {
                            TutorialView()
                                .preferredColorScheme(isDark ? .dark : .light)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                }
            }
            
            if(!hasUser){
                UserNameModal(userName: $userName) {
                    var userList = getUsers()
                    if(userName != ""){
                        if((userList[userName] == nil)){
                            highScore = 0
                            userList[userName] = 0
                            saveUsers(userList: userList)
                            game = Game()
                        }
                        else{
                            highScore = getHighScore(userName: userName)
                            let loaded = loadGame(userName: userName)
                            if(loaded != nil){
                                game = loaded!
                            }else {
                                game = Game()
                            }
                        }
                        hasUser = true
                    }
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
