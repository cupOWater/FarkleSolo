//
//  LeaderboardView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 20/08/2023.
//

import SwiftUI

struct LeaderboardView: View {
    
    @State var userList : [String : Int] = UserDefaults.standard.object(forKey: "users") as? [String : Int] ?? [:]
    
    var body: some View {
        ZStack{
            VStack{
                Text("LEADERBOARD")
                    .font(.custom("Supfun", size: 55))
                ScrollView {
                    VStack {
                        ForEach (userList.sorted {$0.1 > $1.1}, id: \.key) {key, value in
                            HStack {
                                Text("\(key)")
                                    .font(.custom("Supfun", size: 30))
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                Spacer()
                                Text("\(value) pts")
                                    .font(.system(size: 24))
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                            }
                            .frame(maxWidth: 300)
                        }
                    }
                }
                .padding()
                .border(.black)
                .background(.white)
                .scrollIndicators(.visible)
                .frame(height: 300)
            
                Text("Your Achievements:")
                    .font(.custom("Supfun", size: 35))
                    .underline()
                
                Spacer()
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
