//
//  PauseModal.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import SwiftUI

struct PauseModal: View {
    @AppStorage("language") var lang : String = "en"

    @Binding var isPaused : Bool
    var dismiss : () -> Void
    @State var showTutorial = false
    
    init(isPaused: Binding<Bool>, dismiss: @escaping () -> Void) {
        self._isPaused = isPaused
        self.dismiss = dismiss
    }
    
    var body : some View {
        ZStack{
            Color(.black)
                .opacity(0.3)
            
            VStack{
                Text("PAUSED".localized(lang: lang))
                    .font(.custom("coiny-regular", size: 60))
                    .foregroundColor(.black)
                    .padding(.bottom, -1)
                
                VStack{
                    Button {
                        isPaused = false
                    } label: {
                        MainMenuButton(textLabel: "Resume", disabled: false, textColor: .white, backgroundColor: .orange)
                    }
                    Button {
                        // How to play sheet
                        showTutorial.toggle()
                    } label: {
                        MainMenuButton(textLabel: "Game Rule", disabled: false, textColor: .white, backgroundColor: .black)
                    }
                    .sheet(isPresented: $showTutorial) {
                        TutorialView()
                    }
                    Button {
                        dismiss()
                    } label: {
                        MainMenuButton(textLabel: "Back", disabled: false, textColor: .white, backgroundColor: .black)
                    }
                }
                .padding(.bottom, 40)
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: 500)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct PauseModal_Previews: PreviewProvider {
    static var previews: some View {
        PauseModal(isPaused: .constant(true)) {
            
        }
    }
}
