/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 2
  Author: Huynh Ky Thanh
  ID: 3884734
  Created  date: 11/08/2023
  Last modified: 01/09/2023
  Acknowledgement:
 
*/


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
                        // If darkmode, invert the color
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
                    
                    // NavLinks
                    VStack {
                        Text("Username: \(userName)")
                            .font(.custom("coiny-regular", size: 25))
                            .foregroundColor(Color("dark"))
                        Text("Highscore: \(highScore)")
                            .font(.custom("coiny-regular", size: 25))
                            .foregroundColor(Color("dark"))
                        
                        // MARK: Continue button
                        // If there is a started game, the button will be available
                        NavigationLink {
                            GameView(maxTurn: maxTurn, userName: userName, game: $game, highScore: $highScore)
                            
                        } label: {
                            MainMenuButton(textLabel: "continue", disabled: !game.hasStart)
                        }
                        .disabled(!game.hasStart)
                        
                        // MARK: New game button
                        // Create a new game object
                        NavigationLink {
                            GameView(maxTurn: maxTurn, userName: userName, game: $game, highScore: $highScore)
                        } label: {
                            MainMenuButton(textLabel: "newGame", disabled: false)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            game = Game()
                            saveGame(userName: userName, game: game)
                        })
                        
                        // MARK: Leaderboard button
                        NavigationLink {
                            LeaderboardView(userName: userName)
                        } label: {
                            MainMenuButton(textLabel: "leaderboard", disabled: false)
                        }
                        
                        // MARK: Setting button
                        NavigationLink {
                            SettingView(isDark: $isDark, maxTurn: $maxTurn, hasUser: $hasUser)
                        } label: {
                            MainMenuButton(textLabel: "setting", disabled: false)
                        }
                        
                        // MARK: Tutorial button
                        // Will show a sheet to show user how to play the game
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
            
            // If there is no user
            // Display a user modal to ask for a username
            if(!hasUser){
                UserNameModal(userName: $userName) {
                    var userList = getUsers()
                    if(userName != ""){
                        // If no user, create a new user with no game and no highscore
                        if((userList[userName] == nil)){
                            highScore = 0
                            userList[userName] = 0
                            saveUsers(userList: userList)
                            game = Game()
                        }
                        else{
                            // If there is a user, set the highscore and the previous game if present
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
        .onAppear{
            // MARK: BG Music
            playSound(sound: "background", type: "wav", loop: -1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
