//
//  PauseModal.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import SwiftUI

struct PauseModal: View {
    
    @Binding var isPaused : Bool
    var dismiss : () -> Void
    
    init(isPaused: Binding<Bool>, dismiss: @escaping () -> Void) {
        self._isPaused = isPaused
        self.dismiss = dismiss
    }
    
    var body : some View {
        ZStack{
            Color(.black)
                .opacity(0.3)
            
            VStack{
                Text("PAUSED")
                    .font(.custom("Supfun", size: 60))
                    .foregroundColor(.black)
                
                VStack{
                    Button {
                        isPaused = false
                    } label: {
                        MainMenuButton(textLabel: "Resume", disabled: false, textColor: .white, backgroundColor: .blue)
                    }
                    NavigationLink {
                        // How to play view
                    } label: {
                        MainMenuButton(textLabel: "Game Rule", disabled: false, textColor: .white, backgroundColor: .black)
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
