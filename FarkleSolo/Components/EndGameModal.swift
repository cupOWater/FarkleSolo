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

struct EndGameModal: View {
    @AppStorage("language") var lang : String = "en"

    let score : Int
    let neededScore : Int
    let newHighScore : Bool
    let dimiss : () -> Void
    let nextStage : () -> Void
    
    init(score: Int, neededScore: Int, newHighScore: Bool, dimiss: @escaping () -> Void, nextStage: @escaping () -> Void) {
        self.score = score
        self.neededScore = neededScore
        self.newHighScore = newHighScore
        self.dimiss = dimiss
        self.nextStage = nextStage
    }
    
    var body: some View {
        ZStack{
            Color(.black)
                .opacity(0.3)
            
            VStack{
                Text((score >= neededScore ? "VICTORY" : "LOSE").localized(lang: lang))
                    .font(.custom("coiny-regular", size: 60))
                    .foregroundColor(score >= neededScore ? .orange : .black)
                    .padding(.bottom, -70)
                
                Text("\(String(score)) / \(String(neededScore))")
                    .font(.custom("coiny-regular", size: 45))
                    .foregroundColor(.black)
                
                if(newHighScore){
                    HStack {
                        Image(systemName: "star.fill")
                        Text("New Highscore")
                            .font(.custom("Supfun", size: 30))
                        Image(systemName: "star.fill")
                    }
                    .foregroundColor(.orange)
                }
                
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
                        MainMenuButton(textLabel: "Next Stage", disabled: score < neededScore, textColor: .white, backgroundColor: .orange)
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
        EndGameModal(score: 200, neededScore: 100, newHighScore: true) {
            
        } nextStage: {
            
        }

    }
}
