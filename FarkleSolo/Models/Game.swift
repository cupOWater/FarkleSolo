//
//  Game.swift
//  FarkleSolo
//
//  Created by MacNCheese on 19/08/2023.
//

import Foundation

struct Game : Codable, Hashable{
    var hasStart : Bool = false
    var canContinue : Bool = true
    var canRoll : Bool = true
    var canScore : Bool = false
    var stage : Int = 1
    
    var turnScore : Int = 0
    var totalScore : Int = 0
    var neededScore : Int = 1000
    var turnCounter : Int = 1
    var maxTurn : Int = 8
    var rolledDice : [Int] = [1, 1, 1, 1, 1, 1]
    var selected : [Bool] = [false, false, false, false, false, false]
    var used : [Bool] = [false, false, false, false, false, false]
    
   
    func getSelected() -> [Int] {
        var result : [Int] = []
        for i in 0..<selected.count {
            if(selected[i] && !used[i]){
                result.append(rolledDice[i])
            }
        }
        return result
    }
    
    mutating func confirmHand() {
        turnScore += getScore(selectedArr: getSelected())
        for i in 0..<selected.count {
            if(selected[i]){
                used[i] = true
            }
        }
    }
    
    mutating func rollDice(){
        for i in 0..<rolledDice.count {
            if(!used[i]){
                rolledDice[i] = Int.random(in: 1...6)
            }
        }
    }

    func checkUsedAll() -> Bool{
        var allUsed = true
        for i in 0..<used.count{
            if(!used[i]){
                allUsed = false
            }
        }
        return allUsed
    }
    
    mutating func resetUsed() {
        used = [false, false, false, false, false, false]
    }
    
    mutating func resetSelect() {
        selected = [false, false, false, false, false, false]
    }
    
    mutating func deSelectUnused() {
        for i in 0..<used.count {
            if(!used[i]){
                selected[i] = false
            }
        }
    }
    
    mutating func nextTurn(){
        turnCounter += 1
        totalScore += turnScore
        turnScore = 0
        resetUsed()
        resetSelect()
    }
    
    
    mutating private func checkAvailableRecursive(checker : [Bool]) {
        if(canContinue){
            return
        }
        
        if(checker.count == 6){
            var temp : [Int] = []
            for index in 0..<checker.count {
                if(checker[index] && !used[index]){
                    temp.append(rolledDice[index])
                }
            }
            let tempScore = getScore(selectedArr: temp)
            if(tempScore > 0) {
                canContinue = true
            }
        }else {
            var first = checker
            first.append(true)
            checkAvailableRecursive(checker: first)
            var second = checker
            second.append(false)
            checkAvailableRecursive(checker: second)
        }
    }
    
    mutating func checkAvailableMove(){
        canContinue = false
        checkAvailableRecursive(checker: [])
    }
    
    func checkWin() -> Bool{
        if(totalScore >= neededScore){
            return true
        }
        return false
    }
    
    mutating func nextStage() {
        stage += 1
        totalScore = 0
        neededScore += 1000
        turnCounter = 1
        resetUsed()
        resetSelect()
    }
    
    func getScore(selectedArr : [Int]) -> Int {
        let sortedHand = selectedArr.sorted()
        let count = sortedHand.count
        
        if(count == 0 || count == 2){
            return 0
        }
        
        // 1 or 5 valid
        if(count == 1){
            if(sortedHand[0] == 1){
                return 100
            }
            if(sortedHand[0] == 5){
                return 50
            }
            return 0
        }
        
        
        if(count == 6){
            // 3 pairs
            if(sortedHand[0] == sortedHand[1] && sortedHand[2] == sortedHand[3] && sortedHand[4] == sortedHand[5]
            ) {return 750}
            
            // 6 straight
            if (sortedHand[0] == 1 && sortedHand[1] == 2 && sortedHand[2] == 3 && sortedHand[3] == 4 && sortedHand[4] == 5 && sortedHand[5] == 6) {return 1000}
        }
        
        // of a kind
        if(count >= 3){
            var val = sortedHand[0]
            var valid = true
            for i in 1..<count {
                if(sortedHand[i] != val){
                    valid = false
                }
            }
            if(!valid){return 0}
            
            if(val == 1){
                val = 10
            }
            
            return val * 100 + (val * 100) * (count - 3)
        }

        return 0
        
    }

}


