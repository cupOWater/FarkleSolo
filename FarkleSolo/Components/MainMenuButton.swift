//
//  MainMenuButton.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import SwiftUI


struct MainMenuButton: View {
    
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
                    
                Text(textLabel)
                    .padding()
                    .font(.custom("Supfun",size: 50))
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
