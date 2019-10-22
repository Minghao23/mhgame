//
//  TimerViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/22.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class TimerViewController: GameRunViewController {

    @IBOutlet weak var magicWordLabel1: UILabel!
    @IBOutlet weak var magicWordLabel2: UILabel!
    
    var masterPos: Int!
    var magicWord: String!
    var players: [UIButton] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        magicWordLabel2.text = magicWord!
        magicWordLabel1.isHidden = true
        magicWordLabel2.isHidden = true
        for i in 0 ..< identities.count {
            addPlayer(playerPos: i)
        }
    }
    
    func addPlayer(playerPos: Int) {
        let xPos = 19 + (playerPos % 4) * (70 + 19)
        let yPos = 150 + 19 + (playerPos / 4) * (70 + 19)
        let player = UIButton(frame:CGRect(x: xPos, y: yPos, width: 70, height: 70))
        player.layer.masksToBounds = true
        player.layer.cornerRadius = 5.0
        player.tag = playerPos
        player.setTitle(String(playerPos + 1), for: .normal)
        player.setTitle("??", for: .highlighted)
        player.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
        player.backgroundColor = .gray
        player.setTitleColor(.white, for: .normal)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(playerLongPress(_:)))
        longPress.minimumPressDuration = 0.8
        player.addGestureRecognizer(longPress)
        self.view.addSubview(player)
        players.append(player)
    }
    
    @objc func playerLongPress(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            checkDetail(player: gestureRecognizer.view as! UIButton)
        }
    }
    
    @objc func checkDetail(player: UIButton) {
        let playerPos = player.tag
        var msg = "您的身份是：\(identities[playerPos])"
        if playerPos == masterPos! {
            msg = msg + "（村长）"
        }
        if playerPos == masterPos! || identities[playerPos] != "村民" {
            msg = msg + "\n本局的魔法咒语是：\(magicWord!)"
        }
        
        let alert = UIAlertController(title: "玩家信息", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "记住了", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func revealAll(_ sender: UIButton) {
        if sender.currentTitle == "结束游戏" {
            for i in 0 ..< identities.count {
                players[i].setTitle(identities[i], for: .normal)
                players[i].setTitle(String(i + 1), for: .highlighted)
                players[i].removeGestureRecognizer(players[i].gestureRecognizers![0])
            }
            magicWordLabel1.isHidden = false
            magicWordLabel2.isHidden = false
            sender.setTitle("重新开始", for: .normal)
        } else {
            jumpToStart()
        }
    }
}
