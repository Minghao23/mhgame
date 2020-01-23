//
//  NewTeamViewController.swift
//  mhgame
//
//  Created by 胡明昊工作Mac on 2019/12/24.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class EditTeamViewController: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        drawBtn()
    }
    
    func drawBtn() {
        let bound_width = self.view.bounds.width
        let bound_height = self.view.bounds.height
        
        let confirmLabel = UILabel()
        confirmLabel.text = "确定"
        confirmLabel.frame.size = CGSize(width: Int(bound_width / 2), height: 50)
        confirmLabel.textAlignment = .center
        confirmLabel.textColor = .black
        confirmLabel.font = UIFont.systemFont(ofSize: 40.0)
        confirmLabel.center = CGPoint(x: Int(bound_width / 4), y: Int(bound_height - 80))
        
        let deleteLabel = UILabel()
        deleteLabel.text = "删除"
        deleteLabel.frame.size = CGSize(width: Int(bound_width / 2), height: 50)
        deleteLabel.textAlignment = .center
        deleteLabel.textColor = .red
        deleteLabel.font = UIFont.systemFont(ofSize: 40.0)
        deleteLabel.center = CGPoint(x: Int(bound_width - bound_width / 4), y: Int(bound_height - 80))
        
        self.view.addSubview(confirmLabel)
        self.view.addSubview(deleteLabel)
    }
}
