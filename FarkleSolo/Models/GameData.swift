//
//  UserData.swift
//  FarkleSolo
//
//  Created by MacNCheese on 20/08/2023.
//

import Foundation


import Foundation
import CoreLocation


func setHighScore(userName : String, score : Int){
    var userList : [String : Int] = UserDefaults.standard.object(forKey: "users") as? [String : Int] ?? [:]
    
    userList[userName] = score
    UserDefaults.standard.set(userList, forKey: "users")
}

func getHighScore(userName : String) -> Int{
    let userList : [String : Int] = UserDefaults.standard.object(forKey: "users") as? [String : Int] ?? [:]
    
    if((userList[userName]) != nil){
        return userList[userName]!
    }else {
        return 0
    }
}

func saveGame(userName : String, game : Game){
    let gamesData = UserDefaults.standard.data(forKey: "games") 
    var games : [String : Game]?
    if (gamesData != nil){
        games = dataToDict(data: gamesData!)
    }
    else {
        games = [:]
    }
    if(games != nil){
        games![userName] = game
        let data = dictToData(gameDict: games!)
        UserDefaults.standard.set(data, forKey: "games")
    }
}

func loadGame(userName : String) -> Game? {
    let gamesData = UserDefaults.standard.data(forKey: "games")
    if(gamesData == nil){
        return nil
    }
    
    let games = dataToDict(data: gamesData!)
    if (games != nil){
        return games![userName]
    }else {
        return nil
    }
}

func dataToDict(data : Data) -> [String : Game]?{
    let decoder = JSONDecoder()
    
    do {
        let gameDict = try decoder.decode([String : Game].self, from: data)
        return gameDict
    } catch {
        print(error.localizedDescription)
    }
    return nil
}


func dictToData(gameDict : [String :Game]) -> Data{
    do {
       let data = try JSONEncoder().encode(gameDict)
       // Print the encoded JSON data
       return data
    } catch let err {
        fatalError("Failed to encode JSON: \(err)")
    }
}
