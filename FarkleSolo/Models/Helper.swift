//
//  UserData.swift
//  FarkleSolo
//
//  Created by MacNCheese on 20/08/2023.
//

import Foundation


import Foundation
import CoreLocation
import AVFoundation


// dijipiji. (2018, December 5). How can I change locale programmatically with Swift [Online forum post]. StackOverflow. https://stackoverflow.com/a/31744226
extension String {
    func localized (lang: String) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

var audioPlayer : AVAudioPlayer?
func playSound(sound : String, type : String){
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

func getUsers() -> [String: Int]{
    let userList = UserDefaults.standard.object(forKey: "users") as? [String:Int] ?? [:]
    return userList
}


func saveUsers(userList : [String : Int]) {
    UserDefaults.standard.set(userList, forKey: "users")
}


func getAchievementList() -> [String : [String]]{
    return UserDefaults.standard.object(forKey: "achievements") as? [String:[String]] ?? ["stage2" : [], "stage5" : [], "500pts" : [], "2000pts" : []]
}

func saveAchievementList(achievements : [String : [String]]) {
    UserDefaults.standard.set(achievements, forKey: "achievements")
}

func addUserAchievement(userName : String, achievement : String) -> Bool{
    var achievementList = getAchievementList()
    if(achievementList[achievement] == nil){
        achievementList[achievement] = []
    }
    
    if(!achievementList[achievement]!.contains(userName)){
        achievementList[achievement]!.append(userName)
        saveAchievementList(achievements: achievementList)
        return true
    }
    return false
}

func setHighScore(userName : String, score : Int){
    var userList = getUsers()
    userList[userName] = score
    saveUsers(userList: userList)
}




func getHighScore(userName : String) -> Int{
    let userList = getUsers()
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
