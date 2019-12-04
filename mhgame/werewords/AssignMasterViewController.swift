//
//  AssignMasterViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/21.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class AssignMasterViewController: GameRunViewController {
    
    @IBOutlet weak var masterPosLabel: UILabel!
    
    var masterPos: Int!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        masterPosLabel.text = "村长是 \(String(describing: (masterPos! + 1))) 号玩家"
    }
    
    @IBAction func jumpToChooseWord(_ sender: UIButton) {
        let chooseWordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChooseWordViewController") as! ChooseWordViewController
        chooseWordViewController.identities = identities
        chooseWordViewController.masterPos = masterPos
        chooseWordViewController.curPos = masterPos
        present(chooseWordViewController, animated: false)
    }
}
