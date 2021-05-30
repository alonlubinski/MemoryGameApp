//
//  TopTenManager.swift
//  MemoryGameApp
//
//  Created by user196684 on 5/29/21.
//

import Foundation

class TopTenManager {
    
    func getHighscores() -> [Record] {
        if let data = UserDefaults.standard.data(forKey: "highscores"){
            do {
                let decoder = JSONDecoder()
                let highscores = try decoder.decode([Record].self, from: data)
                return highscores.sorted {
                    $0.time < $1.time
                }
            } catch {
                print("Error")
            }
        
        }
        return []
    }
    
    func saveHighscore(record: Record) {
        var hightscores = getHighscores().sorted {
            $0.time < $1.time
        }
        if(hightscores.count == 10){
            hightscores.remove(at: 9)
        }
        hightscores.append(record)
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(hightscores)
            UserDefaults.standard.set(data, forKey: "highscores")
        } catch {
            print("Error")
        }
    }
    
    func checkIfNewHighscore(time: Int) -> Bool {
        let hightscores = getHighscores().sorted {
            $0.time < $1.time
        }
        if(hightscores.count < 10){
            return true
        } else{
            if(time < hightscores[9].time){
                return true
            }
        }
        return false
    }
}
