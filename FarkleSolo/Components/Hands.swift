//
//  Hands.swift
//  FarkleSolo
//
//  Created by MacNCheese on 21/08/2023.
//

import SwiftUI

struct Hands: View {
    var body: some View {
        VStack{
            Text("How to Play")
                .font(.custom("Supfun", size: 70))
                .padding(.bottom, 20)
            
            HStack {
                Text("Hands:")
                    .font(.custom("Supfun", size: 40))
                Spacer()
            }
            
            Group {
                Image("dice_1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 80)
                Text("Single 1 = 100 pts")
                    .font(.custom("Supfun", size: 22))
                    .padding(.bottom, 30)
            }
            
            Group {
                Image("dice_5")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 80)
                Text("Single 5 = 50 pts")
                    .font(.custom("Supfun", size: 22))
                    .padding(.bottom, 30)
            }
            
            Group {
                HStack{
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Text("= 300pts")
                        .font(.custom("Supfun", size: 22))
                }
                Text("Three of a Kind = value x 100 pts")
                    .font(.custom("Supfun", size: 22))
                Text("* 1 counts as 10")
                    .font(.custom("Supfun", size: 22))
                    .padding(.bottom, 30)
            }
            
            Group {
                HStack {
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .frame(maxWidth: 80)
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .frame(maxWidth: 80)
                }
                Text("300 + 300 + 300 pts")
                    .font(.custom("Supfun", size: 22))
                Text("Many of a kind")
                    .font(.custom("Supfun", size: 22))
                
                Text("+3 of a kind for every repeat")
                    .font(.custom("Supfun", size: 22))
                    .padding(.bottom, 30)
            }
            
            Group {
                HStack {
                    Image("dice_2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_5")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                }
                HStack {
                    Image("dice_6")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_6")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_5")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                }
                Text("Triple pairs = 750 pts")
                    .font(.custom("Supfun", size: 22))
                    .padding(.bottom, 30)
            }
            
            Group {
                HStack {
                    Image("dice_1")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_3")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                }
                HStack {
                    Image("dice_4")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_5")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                    Image("dice_6")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 80)
                }
                Text("6 Straight = 1000 pts")
                    .font(.custom("Supfun", size: 22))
                    .padding(.bottom, 30)
            }
        }
    }
}

struct Hands_Previews: PreviewProvider {
    static var previews: some View {
        Hands()
    }
}
