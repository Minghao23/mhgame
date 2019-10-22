//
//  AfterRevealViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/22.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class AfterRevealViewController: GameRunViewController {
    
    @IBOutlet weak var curPosLabel: UILabel!
    @IBOutlet weak var identityLabel: UILabel!
    @IBOutlet weak var magicWordLabel: UILabel!
    
    var masterPos: Int!
    var curPos: Int!
    var magicWord: String!
        
    override func viewDidLoad(){
        super.viewDidLoad()
        curPosLabel.text = "您是 \(String(describing: (curPos! + 1))) 号玩家"
        identityLabel.text = identities![curPos!]
        magicWordLabel.text = getDisplayWord()
    }

    func getDisplayWord() -> (String) {
        var displayWord = magicWord!
        if curPos! != masterPos! && identities![curPos!] == "村民" {
            displayWord = ""
        }
        return displayWord
    }
    
    @IBAction func jumpToBeforeReveal(_ sender: Any) {
        let nextPos = (curPos! + 1) % identities!.count
        if nextPos == masterPos! {
            let timerViewController = self.storyboard?.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
            timerViewController.identities = identities
            timerViewController.masterPos = masterPos
            timerViewController.magicWord = magicWord
            present(timerViewController, animated: false)
        } else {
            let beforeRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "BeforeRevealViewController") as! BeforeRevealViewController
            beforeRevealViewController.identities = identities
            beforeRevealViewController.masterPos = masterPos
            beforeRevealViewController.curPos = nextPos
            beforeRevealViewController.magicWord = magicWord
            present(beforeRevealViewController, animated: false)
        }
    }
}
