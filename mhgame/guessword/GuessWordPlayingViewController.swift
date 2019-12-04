//
//  GuessWordPlayingViewController.swift
//  mhgame
//
//  Created by 胡明昊工作Mac on 2019/10/24.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class GuessWordPlayingViewController: UIViewController {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var bingoLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var avgReactionTimeLabel: UILabel!

    var passNum: Int!
    var bingoNum: Int!
    var dataset: [String]!
    var index: Int = -1
    var lastTimestamp: Double!
    var totalSeconds: Double!
    var validReactionNum: Int!
    var avgReactionTime: Double!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        passNum = 0
        passLabel.text = "Pass: \(passNum!)"
        bingoNum = 0
        bingoLabel.text = "Bingo: \(bingoNum!)"
        totalLabel.text = "Total: \(passNum! + bingoNum!)"
        accuracyLabel.text = "Accuracy: 0%"
        avgReactionTimeLabel.text = "Avg Reaction Time: 0.00s"
        
        lastTimestamp = Date().timeIntervalSince1970
        totalSeconds = 0.0
        validReactionNum = 0
        avgReactionTime = 0.0
        
        addButtons()
        addRestartButton()
        
        dataset.shuffle()
        newWord()
    }
    
    func updateStat() {
        passLabel.text = "Pass: \(passNum!)"
        bingoLabel.text = "Bingo: \(bingoNum!)"
        totalLabel.text = "Total: \(passNum! + bingoNum!)"
        accuracyLabel.text = "Accuracy: \(bingoNum! * 100 / (passNum! + bingoNum!))%"
        avgReactionTimeLabel.text = "Avg Reaction Time: \(String(format:"%.2f",avgReactionTime!))s"
        lastTimestamp = Date().timeIntervalSince1970
    }
    
    func newWord() {
        index += 1
        if index >= dataset.count {
            wordLabel.text = "（词库已空）"
        } else {
            wordLabel.text = dataset[index]
        }
    }
    
    func addButtons() {
        // Pass button
        let passBtn = UIButton(frame:CGRect(x: 25, y: 500, width: 150, height: 100))
        passBtn.layer.masksToBounds = true
        passBtn.layer.cornerRadius = 10.0
        passBtn.setTitle("Pass", for: .normal)
        passBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
        passBtn.backgroundColor = UIColor.init(red: 255/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
        passBtn.setTitleColor(.white, for: .normal)
        passBtn.addTarget(self, action: #selector(pressPass), for: .touchUpInside)
        self.view.addSubview(passBtn)
        
        // Bingo button
        let bingoBtn = UIButton(frame:CGRect(x: 200, y: 500, width: 150, height: 100))
        bingoBtn.layer.masksToBounds = true
        bingoBtn.layer.cornerRadius = 10.0
        bingoBtn.setTitle("Bingo!", for: .normal)
        bingoBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30.0)
        bingoBtn.backgroundColor = UIColor.init(red: 100/255.0, green: 230/255.0, blue: 100/255.0, alpha: 1)
        bingoBtn.setTitleColor(.white, for: .normal)
        bingoBtn.addTarget(self, action: #selector(pressBingo), for: .touchUpInside)
        self.view.addSubview(bingoBtn)
    }
    
    @objc func pressPass() {
        if index < dataset.count {
            passNum += 1
            updateStat()
        }
        newWord()
    }
    
    @objc func pressBingo() {
        if index < dataset.count {
            bingoNum += 1
            let curTimestamp = Date().timeIntervalSince1970
            let reactionTime = curTimestamp - lastTimestamp
            // reaction time over 1min is considered to be a fake sample
            if reactionTime < 60 {
                totalSeconds += reactionTime
                validReactionNum += 1
                avgReactionTime = totalSeconds! / Double(validReactionNum!)
            }
            updateStat()
        }
        newWord()
    }
    
    func addRestartButton() {
        let restart = UIButton(frame:CGRect(x: 20, y: 20, width: 100, height: 50));
        restart.setTitle("重新开始", for: .normal)
        restart.contentHorizontalAlignment = .left
        restart.backgroundColor = .white
        restart.setTitleColor(.gray, for: .normal)
        restart.addTarget(self, action: #selector(jumpToStart), for: .touchUpInside)
        self.view.addSubview(restart)
    }
    
    @objc func jumpToStart() {
        let guessWordStartViewController = self.storyboard?.instantiateViewController(withIdentifier: "GuessWordStartViewController") as! GuessWordStartViewController
        present(guessWordStartViewController, animated: false)
    }
}

