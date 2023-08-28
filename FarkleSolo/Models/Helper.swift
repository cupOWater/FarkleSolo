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
        // Change the string based on the localized files
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

var audioPlayer : AVAudioPlayer?
func playSound(sound : String, type : String, loop : Int = 0){
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.numberOfLoops = loop
            audioPlayer?.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

// MARK: For changing "users" UserDefaults
func getUsers() -> [String: Int]{
    let userList = UserDefaults.standard.object(forKey: "users") as? [String:Int] ?? [:]
    return userList
}


func saveUsers(userList : [String : Int]) {
    UserDefaults.standard.set(userList, forKey: "users")
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

// MARK: For changing "stat" UserDefaults
func getStats() -> [String : [Int]] {
    let stats = UserDefaults.standard.object(forKey: "stat") as? [String:[Int]] ?? [:]
    return stats
}

func saveStats(stats : [String : [Int]]){
    UserDefaults.standard.set(stats, forKey: "stat")
}

func getStat(userName : String) -> [Int] {
    // Index 0: stages passed, Index 1: stages played
    var stats = getStats()
    if(stats[userName] != nil){
        return stats[userName]!
    }
    else {
        stats[userName] = [0, 0]
        saveStats(stats: stats)
        return [0, 0]
    }
}

func addStatStagePlayed(userName : String) {
    var stats = getStats()
    var stat = getStat(userName: userName)
    stat[1] += 1
    stats[userName] = stat
    saveStats(stats: stats)
}

func addStatWinStage(userName: String) {
    var stats = getStats()
    var stat = getStat(userName: userName)
    stat[0] += 1
    stats[userName] = stat
    saveStats(stats: stats)
}


// MARK: For changing "achievements" UserDefaults
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


// MARK: For changing "games" UserDefaults
// Each user will have their own game
// If the game has started, it will be saved here, else a new game will be start
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


// MARK: For processing the Game struct
// So that it can be convert into Data type
// and can be stored in UserDefaults
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
