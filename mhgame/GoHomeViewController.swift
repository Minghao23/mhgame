//
//  GoHomeViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/24.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class GoHomeViewController: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addHomeButton()
    }
    
    func addHomeButton() {
        let home = UIButton(frame:CGRect(x: 20, y: 20, width: 100, height: 50))
        home.setTitle("主页", for: .normal)
        home.contentHorizontalAlignment = .left
        home.backgroundColor = .white
        home.setTitleColor(.gray, for: .normal)
        home.addTarget(self, action: #selector(jumpToHome), for: .touchUpInside)
        self.view.addSubview(home)
    }
    
    @objc func jumpToHome() {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        present(homeViewController, animated: false)
    }
}
