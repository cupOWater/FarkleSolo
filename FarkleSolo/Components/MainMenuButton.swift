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


struct MainMenuButton: View {
    @AppStorage("language") var lang : String = "en"

    let textLabel : String
    let disabled : Bool
    @State var width : CGFloat = 400
    @State var textColor : Color = Color("light")
    @State var backgroundColor : Color = Color("dark")
    
    
    
    var body: some View {
        
            let opacity = disabled ? 0.5 : 1
            ZStack{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(backgroundColor)
                    
                Text(textLabel.localized(lang: lang))
                    .padding()
                    .font(.custom("coiny-regular",size: 50))
                    .minimumScaleFactor(0.01)
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: width, maxHeight: 100)
            .opacity(opacity)
            
    }
}

struct MainMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuButton(textLabel: "LEADERBOARD", disabled: true)
    }
}
