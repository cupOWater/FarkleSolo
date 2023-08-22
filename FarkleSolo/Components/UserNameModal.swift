//
//  UserNameModal.swift
//  FarkleSolo
//
//  Created by MacNCheese on 20/08/2023.
//

import SwiftUI


struct UserNameModal: View {
    @AppStorage("language") var lang : String = "en"
    @Binding var userName : String
    var confirmUser : () -> Void
    
    init(userName: Binding<String>, confirmUser: @escaping () -> Void) {
        self._userName = userName
        self.confirmUser = confirmUser
    }
    
    var body: some View {
        ZStack{
            Color(.black)
                .opacity(0.3)
            
            VStack{
                Text("WHO ARE YOU?".localized(lang: lang))
                    .font(.custom("coiny-regular", size: 40))
                    .foregroundColor(.black)
                    .padding(.bottom, -1)
                TextField("Username", text: $userName)
                    .font(.custom("coiny-regular", size: 35))
                    .multilineTextAlignment(.center)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    .overlay{RoundedRectangle(cornerRadius: 10).stroke(.gray)}
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .padding(.top, -10)
                    
                
                Button {
                    confirmUser()
                } label: {
                    MainMenuButton(textLabel: "Confirm", disabled: userName == "", textColor: .white, backgroundColor: .black)
                }
                .disabled(userName == "")
                .padding(.bottom, 50)
                .padding(.horizontal, 40)

            }
            .frame(maxWidth: 500)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct UserNameModal_Previews: PreviewProvider {
    static var previews: some View {
        UserNameModal(userName: .constant("")) {
            
        }
    }
}
