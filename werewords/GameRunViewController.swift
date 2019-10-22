//
//  GameRunViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/22.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class GameRunViewController: UIViewController {
    
    var identities: [String]!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addRestartButton()
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
        let startViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        startViewController.playerNum = identities.count
        startViewController.wolfNum = identities.filter{$0 == "狼人"}.count
        present(startViewController, animated: false)
    }
}
