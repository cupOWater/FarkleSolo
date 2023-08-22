//
//  AchivementNoti.swift
//  FarkleSolo
//
//  Created by MacNCheese on 22/08/2023.
//

import SwiftUI

struct AchivementNoti: View {
    @AppStorage("language") var lang : String = "en"

    let achievementMsg : String
    init(achievement: String) {
        self.achievementMsg = {
            switch (achievement) {
            case "stage2":
                return "Reach Stage 2"
            case "stage5":
                return "Reach Stage 5"
            case "500pts":
                return "Earn 500 points in 1 turn"
            case "2000pts":
                return "Earn 2000 points in 1 turn"
                
            default:
                return ""
            }
        }()
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
                .frame(maxWidth: 400, maxHeight: 100)
                .shadow(radius: 10, y: 10)
            VStack{
                HStack{
                    Image(systemName: "star.fill")
                    Text("Achievement Earned!".localized(lang: lang))
                        .font(.custom("coiny-regular", size: 25))
                    Image(systemName: "star.fill")
                }
                .foregroundColor(.orange)
                    
                Text(achievementMsg.localized(lang: lang))
                    .font(.custom("coiny-regular", size: 20))
            }
            .foregroundColor(.black)
        }
        .padding(.horizontal, 20)
    }
}

struct AchivementNoti_Previews: PreviewProvider {
    static var previews: some View {
        AchivementNoti(achievement: "2000pts")
    }
}
