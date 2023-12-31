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

struct AchievementList: View {
    @AppStorage("language") var lang : String = "en"

    let userName : String
    let achievementList : [String : [String]] = getAchievementList()
    let achievement : String
    var achievementHeader : String = ""
    var achievementIconStr : String = ""
    
    init(userName: String, achievement: String){
        self.userName = userName
        self.achievement = achievement
        // MARK: Achievement properties
        // Each achievement includes an image and an achievement message
        switch (achievement) {
        case "stage2":
            achievementHeader = "Reach Stage 2"
            achievementIconStr = "seal"
            break
        case "stage5":
            achievementHeader = "Reach Stage 5"
            achievementIconStr = "seal.fill"
            break
        case "500pts":
            achievementHeader = "Earn 500 points in 1 turn"
            achievementIconStr = "star.leadinghalf.filled"
            break
        case "2000pts":
            achievementHeader = "Earn 2000 points in 1 turn"
            achievementIconStr = "star.fill"
            break
        default:
            break
        }
    }
    
    var body: some View {
        if(achievementList[achievement] != nil){
            VStack{
                HStack {
                    Image(systemName: achievementIconStr)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                    Text(achievementHeader.localized(lang: lang))
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .font(.custom("coiny-regular", size: 25))
                }
                .foregroundColor(.orange)
                .padding(.bottom, -5)
                ScrollView {
                    VStack {
                        // MARK: List of users that can have achieved this achievement
                        ForEach(achievementList[achievement]!, id: \.self){name in
                            HStack{
                                Text(name)
                            }
                            .frame(maxWidth: .infinity)
                            .font(.custom("coiny-regular", size: 25))
                            .lineLimit(1)
                            .foregroundColor(name == userName ? .white : Color("dark"))
                            .background(name == userName ? .orange : .clear)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 150)
            }
            .padding()
            .border(Color("dark"))
            .padding(.bottom, 10)
        }
    }
}

struct AchievementList_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AchievementList(userName: "David", achievement: "500pts")
        }
    }
}
