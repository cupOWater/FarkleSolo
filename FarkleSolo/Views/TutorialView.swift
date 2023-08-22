//
//  TutorialView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 21/08/2023.
//

import SwiftUI


struct TutorialView: View {
    let isDark = UserDefaults.standard.bool(forKey: "darkMode")
    @AppStorage("language") var lang : String = "en"
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundColor(Color("dark"))
            }
            .padding(.top, 10)

            ScrollView{
                VStack{
                    Text("how2play".localized(lang: lang))
                        .font(.custom("coiny-regular", size: 45))
                        
                    
                    HStack {
                        Text("\("Hands".localized(lang: lang)):")
                            .font(.custom("coiny-regular", size: 40))
                        Spacer()
                    }
                    
                    Group {
                        Group {
                            Image("dice_1")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                            Text("Single 1 = 100 pts")
                                .font(.custom("coiny-regular", size: 22))
                                .padding(.bottom, 30)
                        }
                        Group {
                            Image("dice_5")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                            Text("Single 5 = 50 pts")
                                .font(.custom("coiny-regular", size: 22))
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
                                Text("= 300")
                                    .font(.custom("coiny-regular", size: 22))
                            }
                            Text("Three of a Kind = value x 100")
                                .font(.custom("coiny-regular", size: 22))
                            
                            Text("* 1 counts as 10")
                                .font(.custom("coiny-regular", size: 22))
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
                                .font(.custom("coiny-regular", size: 22))
                            Text("Many of a kind")
                                .font(.custom("coiny-regular", size: 22))
                            
                            Text("+3 of a kind for every repeat")
                                .font(.custom("coiny-regular", size: 22))
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
                                .font(.custom("coiny-regular", size: 22))
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
                                .font(.custom("coiny-regular", size: 22))
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("\("Rules".localized(lang: lang)):")
                            .font(.custom("coiny-regular", size: 40))
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack (alignment: .top) {
                            Text("\u{2022}  ")
                            Text("rule1".localized(lang: lang))
                        }.padding(.bottom, 10)
                        HStack (alignment: .top) {
                            Text("\u{2022}  ")
                            Text("rule2".localized(lang: lang))
                        }.padding(.bottom, 10)
                        HStack (alignment: .top) {
                            Text("\u{2022}  ")
                            Text("rule3".localized(lang: lang))
                        }.padding(.bottom, 10)
                        HStack (alignment: .top) {
                            Text("\u{2022}  ")
                            Text("rule4".localized(lang: lang))
                        }.padding(.bottom, 10)
                        HStack (alignment: .top) {
                            Text("\u{2022}  ")
                            Text("rule5".localized(lang: lang))
                        }.padding(.bottom, 10)
                        HStack (alignment: .top) {
                            Text("\u{2022}  ")
                            Text("rule6".localized(lang: lang))
                        }.padding(.bottom, 10)
                    }
                    .font(.custom("coiny-regular", size: 24))
                    .fixedSize(horizontal: false, vertical: true)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
