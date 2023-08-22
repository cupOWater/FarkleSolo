//
//  MainMenuView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 21/08/2023.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(\.colorScheme) var scheme
    @State var isDark : Bool = false
    @State var maxTurn : Int = 8
    @State var hasUser : Bool = false
    @State var userName : String = ""
    @State var onGameView : Bool = false
    
    
    @State var game : Game = Game()
    @State var userList : [String : Int] = UserDefaults.standard.object(forKey: "users") as? [String : Int] ?? [:]


    var body: some View {
        
        
        ZStack {
            NavigationStack() {
                VStack {
                    // Logo
                    HStack{
                        if(scheme == .dark){
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
                        Text("Highscore: \(getHighScore(userName: userName))")
                            .font(.custom("Supfun", size: 30))
                            .foregroundColor(Color("dark"))
                        
                        Button {
                            onGameView = true
                            
                        } label: {
                            MainMenuButton(textLabel: "CONTINUE", disabled: !game.hasStart)
                        }.disabled(!game.hasStart)
                        
                        
                        Button {
                            game = Game()
                            onGameView = true
                        } label: {
                            MainMenuButton(textLabel: "NEW GAME", disabled: false)
                        }
                        
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
            
            if(onGameView){
                GameView(maxTurn: maxTurn, userName: userName, game: $game)
            }
            
            if(!hasUser){
                UserNameModal(userName: $userName) {
                    
                    if(userName != ""){
                        
                        if((userList[userName] == nil)){
                            userList[userName] = 0
                            UserDefaults.standard.set(userList, forKey: "users")
                        }
                        let loaded = loadGame(userName: userName)
                        if(loaded != nil){
                            game = loaded!
                        }
                        
                        hasUser = true
                    }
                }
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
