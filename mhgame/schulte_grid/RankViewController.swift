//
//  RankViewController.swift
//  mhgame
//
//  Created by 胡明昊工作Mac on 2020/1/9.
//  Copyright © 2020年 hmh. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        drawBackButton()
        drawRankList()
    }
    
    func drawRankList() {
        let bound_width = self.view.bounds.width
        let bound_height = self.view.bounds.height
        
        // title
        let titleLabel = UILabel()
        titleLabel.text = "排行榜"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30.0)
        titleLabel.frame = CGRect(x: 0, y: 50, width: Int(bound_width), height: 70)
        self.view.addSubview(titleLabel)
        
        // list
       
    }
    
    func drawBackButton() {
        let backBtn = UIButton(frame:CGRect(x: 20, y: 20, width: 100, height: 50))
        backBtn.setTitle("返回", for: .normal)
        backBtn.contentHorizontalAlignment = .left
        backBtn.backgroundColor = .white
        backBtn.setTitleColor(.gray, for: .normal)
        backBtn.addTarget(self, action: #selector(jumpToStart), for: .touchUpInside)
        self.view.addSubview(backBtn)
    }
    
    @objc func jumpToStart() {
        let schulteGridStartViewController = self.storyboard?.instantiateViewController(withIdentifier: "SchulteGridStartViewController") as! SchulteGridStartViewController
        present(schulteGridStartViewController, animated: false)
    }
}
