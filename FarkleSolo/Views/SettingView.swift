//
//  SettingView.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var isDark : Bool
    @Binding var maxTurn : Int
    
    var body: some View {
        ZStack{
            VStack{
                Text("SETTING")
                    .font(.custom("Supfun", size: 70))
                
                VStack {
                    Toggle(isOn: $isDark){
                        Text("Dark Mode")
                            .font(.custom("Supfun", size: 35))
                    }
                    HStack {
                        Text("Turns Count")
                            .font(.custom("Supfun", size: 35))
                        Spacer()
                        Menu {
                            Picker("", selection: $maxTurn) {
                                Text("8").tag(8)
                                Text("6").tag(6)
                                Text("4").tag(4)
                            }
                        } label: {
                            HStack {
                                Text("\(String(maxTurn)) Turns")
                                    .font(.custom("Supfun", size: 30))
                                    .foregroundColor(Color("dark"))
                                Image(systemName: "chevron.down")
                                    .bold()
                                    .foregroundColor(Color("dark"))
                            }.fixedSize()
                        }

                        
                    }
                }
                .frame(maxWidth: 500)
                .padding(.horizontal, 20)
                
                
                Spacer()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isDark: .constant(false), maxTurn: .constant(8))
    }
}
