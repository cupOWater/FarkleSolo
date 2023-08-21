//
//  VictoryModal.swift
//  FarkleSolo
//
//  Created by MacNCheese on 20/08/2023.
//

import SwiftUI

struct EndGameModal: View {
    
    let score : Int
    let neededScore : Int
    let dimiss : () -> Void
    let nextStage : () -> Void
    
    init(score: Int, neededScore: Int, dimiss: @escaping () -> Void, nextStage: @escaping () -> Void) {
        self.score = score
        self.neededScore = neededScore
        self.dimiss = dimiss
        self.nextStage = nextStage
    }
    
    var body: some View {
        ZStack{
            Color(.black)
                .opacity(0.3)
            
            VStack{
                Text(score >= neededScore ? "VICTORY" : "LOSE")
                    .font(.custom("Supfun", size: 70))
                    .foregroundColor(score >= neededScore ? .yellow : .black)
                
                Text("\(String(score)) / \(String(neededScore))")
                    .font(.custom("Supfun", size: 50))
                    .foregroundColor(.black)
                
                HStack {
                    Spacer()
                    Button {
                        dimiss()
                    } label: {
                        MainMenuButton(textLabel: "Back", disabled: false, textColor: .white, backgroundColor: .black)
                    }
                    Spacer()
                    Button {
                        nextStage()
                    } label: {
                        MainMenuButton(textLabel: "Next Stage", disabled: score < neededScore, textColor: .white, backgroundColor: .blue)
                    }
                    .disabled(score < neededScore)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                
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

struct EndGameModal_Previews: PreviewProvider {
    static var previews: some View {
        EndGameModal(score: 10, neededScore: 100) {
            
        } nextStage: {
            
        }

    }
}
