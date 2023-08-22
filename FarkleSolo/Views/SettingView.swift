//
//  SettingView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isDark : Bool
    @Binding var maxTurn : Int
    @Binding var hasUser : Bool
    @AppStorage("language") var lang : String = "en"

    
    var body: some View {
        ZStack{
            VStack{
                Text("setting".localized(lang: lang))
                    .font(.custom("coiny-regular", size: 70))
                Spacer()
                VStack {
                    Toggle(isOn: $isDark){
                        Text("darkMode".localized(lang: lang))
                            .font(.custom("coiny-regular", size: 30))
                    }
                    HStack {
                        Text("turn".localized(lang: lang))
                            .font(.custom("coiny-regular", size: 30))
                        Spacer()
                        Menu {
                            Picker("", selection: $maxTurn) {
                                Text("8").tag(8)
                                Text("6").tag(6)
                                Text("4").tag(4)
                            }
                        } label: {
                            HStack {
                                Text("\(String(maxTurn))")
                                    .font(.custom("coiny-regular", size: 25))
                                    .foregroundColor(Color("dark"))
                                Image(systemName: "chevron.down")
                                    .bold()
                                    .foregroundColor(Color("dark"))
                            }.fixedSize()
                        }
                    }
                    HStack {
                        Text("language".localized(lang: lang))
                            .font(.custom("coiny-regular", size: 30))
                        Spacer()
                        Button {
                            lang = lang == "en" ? "vi" : "en"
                        } label: {
                            Text(lang == "en" ? "English" : "Tiếng Việt")
                                .font(.custom("coiny-regular", size: 25))
                                .foregroundColor(Color("dark"))
                        }

                    }
                    Spacer()
                    Button {
                        hasUser = false
                        dismiss()
                    } label: {
                        MainMenuButton(textLabel: "logout".localized(lang: lang), disabled: false)
                    }.padding(.bottom,30)

                }
                .frame(maxWidth: 500)
                .padding(.horizontal, 20)
                
                
                Spacer()
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
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isDark: .constant(false), maxTurn: .constant(8), hasUser: .constant(true))
    }
}
