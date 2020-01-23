//
//  models.swift
//  mhgame
//
//  Created by 胡明昊工作Mac on 2019/12/24.
//  Copyright © 2019年 hmh. All rights reserved.
//

import Foundation

class DataCenter {
    var teams: [Team] = []
    
    func addTeam(_ name: String) {
        let team = Team(name)
        self.teams.append(team)
    }
    
    func removeTeam(idx: Int) {
        self.teams.remove(at: idx)
    }
    
    func updateTeam(idx: Int, name: String) {
        self.teams[idx].name = name
    }
}


class Team {
    var name: String
    var players: [Player] = []
    
    init(_ name: String) {
        self.name = name
    }
    
    func addPlayer(_ name: String, position: String = "-") {
        let player = Player(name, position: position)
        self.players.append(player)
    }
    
    func removePlayer(idx: Int) {
        self.players.remove(at: idx)
    }
    
    func updatePlayer(idx: Int, name: String, position: String = "-") {
        self.players[idx].name = name
        self.players[idx].position = position
    }
    
    func getTeamRecord() -> Record{
        let team_record = Record()
        for p in players {
            for key in team_record.items.keys {
                team_record.items[key] = team_record.items[key]! + p.record.items[key]!
            }
        }
        return team_record
    }
}


class Player {
    var name: String
    var position: String
    var record: Record = Record()
    
    init(_ name: String, position: String = "-") {
        self.name = name
        self.position = position
    }
}


class Record {
    var items: [String: Int] = [
        "rebound": 0,
        "assist": 0,
        "block": 0,
        "turnover": 0,
        "goal": 0,
        "miss": 0
    ]
    
    var lastAction: String = "undefined"
    
    func addOne(_ item: String) {
        self.items[item] = self.items[item]! + 1
        self.lastAction = item
    }
    
    func cancel() {
        if lastAction == "undefined" {
            print("Error!")
        }
        self.items[self.lastAction] = self.items[self.lastAction]! - 1
    }
    
    func reset() {
        self.items = [
            "rebound": 0,
            "assist": 0,
            "block": 0,
            "turnover": 0,
            "goal": 0,
            "miss": 0
        ]
        self.lastAction = "undefined"
    }
    
    func repr() -> [String: String] {
        var field_goal_percent = 0.0
        let total_field = self.items["goal"]! + self.items["miss"]!
        if total_field > 0 {
            field_goal_percent = (Double(self.items["goal"]!) / Double(total_field)) * 100
        }

        return [
            "PTS": "\(String(describing: self.items["goal"]!))",
            "REB": "\(String(describing: self.items["rebound"]!))",
            "AST": "\(String(describing: self.items["assist"]!))",
            "BLK": "\(String(describing: self.items["block"]!))",
            "TOV": "\(String(describing: self.items["turnover"]!))",
            "FG": "\(String(describing: self.items["goal"]!))/\(total_field)",
            "FG%": "\(String(format:"%.0f", field_goal_percent))%",
        ]
    }
}


//func repr(_ items: [String: Int]) -> [String: String] {
//    var field_goal_percent = 0.0
//    let total_field = items["goal"]! + items["miss"]!
//    if total_field > 0 {
//        field_goal_percent = (Double(items["goal"]!) / Double(total_field)) * 100
//    }
//
//    return [
//        "PTS": "\(String(describing: items["goal"]!))",
//        "REB": "\(String(describing: items["rebound"]!))",
//        "AST": "\(String(describing: items["assist"]!))",
//        "BLK": "\(String(describing: items["block"]!))",
//        "TOV": "\(String(describing: items["turnover"]!))",
//        "FG": "\(String(describing: items["goal"]!))/\(total_field)",
//        "FG%": "\(String(format:"%.0f", field_goal_percent))%",
//    ]
//}


//var record = Record()
//record.addOne("goal")
//record.addOne("miss")
//record.addOne("goal")
//record.addOne("block")
//record.addOne("turnover")
//record.addOne("assist")
//record.addOne("rebound")
//print(record.repr())

//var t = Team("勇士")
//t.addPlayer("hmh")
//t.addPlayer("lwc", position: "SG")
//t.addPlayer("lwc", position: "C")
//
//t.players[0].record.addOne("goal")
//t.players[0].record.addOne("goal")
//t.players[0].record.addOne("miss")
//
//t.players[1].record.addOne("miss")
//t.players[1].record.addOne("rebound")
//t.players[1].record.addOne("assist")
//
//for p in t.players {
//    print(p.name + " " + p.position)
//}
//t.updatePlayer(idx: 1, name: "lwc", position: "PG")
//for p in t.players {
//    print(p.name + " " + p.position)
//}
//
//t.removePlayer(idx: 2)
//for p in t.players {
//    print(p.name + " " + p.position)
//}
//
//print(t.getTeamRecord().repr())
