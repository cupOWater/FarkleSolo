//
//  LeaderboardView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 20/08/2023.
//

import SwiftUI

struct LeaderboardView: View {
    @AppStorage("language") var lang : String = "en"
    @Environment(\.dismiss) private var dismiss
    let userName : String
    let stat : [Int]
    @State var userList : [String : Int] = getUsers()
    
    init(userName : String) {
        self.userName = userName
        self.stat = getStat(userName: userName)
    }
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack{
                    VStack{
                        Text("leaderboard".localized(lang: lang))
                            .font(.custom("coiny-regular", size: 45))
                        Spacer()
                        ScrollView {
                            VStack {
                                ForEach (userList.sorted {$0.1 > $1.1}, id: \.key) {key, value in
                                    HStack {
                                        Text("\(key)")
                                            .font(.custom("coiny-regular", size: 30))
                                            .lineLimit(1)
                                        Spacer()
                                        Text("\(value) pts")
                                            .font(.system(size: 24))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                    }
                                    .padding(.horizontal, 10)
                                    .foregroundColor(userName == key ? .white : Color("dark"))
                                    .background(userName == key ? .orange : .clear)
                                }
                            }.frame(maxWidth: 400)
                            
                        }
                        .padding()
                        .border(Color("dark"))
                        .frame(height: 300)
                        .padding()
                        
                        Text("Stats".localized(lang: lang))
                            .font(.custom("coiny-regular", size: 35))
                            .underline()
                        
                        HStack {
                            VStack {
                                Text("Stage Played".localized(lang: lang))
                                    .font(.custom("coiny-regular", size: 22))
                                Text(String(stat[1]))
                                    .font(.custom("coiny-regular", size: 20))
                            }
                            Spacer()
                            VStack {
                                Text("Stage Won".localized(lang: lang))
                                    .font(.custom("coiny-regular", size: 22))
                                Text(String(stat[0]))
                                    .font(.custom("coiny-regular", size: 20))
                            }
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: 400)
                        
                        Text("Achievements".localized(lang: lang))
                            .font(.custom("coiny-regular", size: 35))
                            .underline()
                        Spacer()
                        VStack {
                            AchievementList(userName: userName, achievement: "stage2")
                            AchievementList(userName: userName, achievement: "stage5")
                            AchievementList(userName: userName, achievement: "500pts")
                            AchievementList(userName: userName, achievement: "2000pts")
                        }
                        .frame(maxWidth: 400)
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color("dark"))
                })
                .transition(.slide)
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(userName: "David")
    }
}
