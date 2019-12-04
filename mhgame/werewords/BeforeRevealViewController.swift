//
//  BeforeRevealViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/22.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class BeforeRevealViewController: GameRunViewController {
    
    @IBOutlet weak var curPosLabel: UILabel!
    
    var masterPos: Int!
    var curPos: Int!
    var magicWord: String!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        curPosLabel.text = "请 \(String(describing: (curPos! + 1))) 号玩家查看身份"
    }
    
    @IBAction func jumpToAfterReveal(_ sender: Any) {
        let afterRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "AfterRevealViewController") as! AfterRevealViewController
        
        afterRevealViewController.identities = identities
        afterRevealViewController.masterPos = masterPos
        afterRevealViewController.curPos = curPos
        afterRevealViewController.magicWord = magicWord
        present(afterRevealViewController, animated: false)
    }
    
}
