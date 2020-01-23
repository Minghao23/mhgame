//
//  ScoreRecorderStartViewController.swift
//  mhgame
//
//  Created by 胡明昊工作Mac on 2019/12/24.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class ScoreRecorderStartViewController: GoHomeViewController {
    
    var leftTeamIdx: Int = -1
    var rightTeamIdx: Int = -1
    var dataCenter: DataCenter = DataCenter()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        dataCenter.addTeam("勇士队")
        dataCenter.addTeam("湖人队")
        
        drawTeams()
        drawVersus()
        drawStart()
    }
    
    func updateView() {
        // tag for each view marks whether they will be updated
        for subv in self.view.subviews {
            if subv.tag > 100 {
                subv.removeFromSuperview()
            }
        }
        drawTeams()
        drawVersus()
    }
    
    func drawTeams() {
        let team_limit = 4
        let bound_width = self.view.bounds.width
        let xPos = Int(bound_width / 2)
        for i in 0 ..< self.dataCenter.teams.count + 1 {
            let yPos = 280 + i * 70
            var teamBtn: UIButton
            if i >= team_limit {
                break
            }
            if i == self.dataCenter.teams.count {
                teamBtn = createTeamButton("+", centerX: xPos, centerY: yPos)
                teamBtn = dashBorder(button: teamBtn)
                teamBtn.addTarget(self, action: #selector(clickAddTeam), for: .touchUpInside)
                teamBtn.tag = 1000 - 1
            } else {
                teamBtn = createTeamButton(self.dataCenter.teams[i].name, centerX: xPos, centerY: yPos)
                teamBtn.tag = 1000 + i
                teamBtn.addTarget(self, action: #selector(clickTeam(teamBtn:)), for: .touchUpInside)
            }
            self.view.addSubview(teamBtn)
        }
    }
    
    func drawVersus() {
        let bound_width = self.view.bounds.width
        let yPos = 150
        var leftTeamBtn: UIButton
        var rightTeamBtn: UIButton
        
        if self.leftTeamIdx == -1 {
            leftTeamBtn = dashBorder(button: createVersusButton("?", color: .white, centerX: Int(bound_width / 4), centerY: yPos))
        } else {
            leftTeamBtn = createVersusButton(dataCenter.teams[leftTeamIdx].name, color: .blue, centerX: Int(bound_width / 4), centerY: yPos)
            leftTeamBtn.addTarget(self, action: #selector(clickLeftTeam), for: .touchUpInside)
        }
        leftTeamBtn.tag = 2000
        
        if self.rightTeamIdx == -1 {
            rightTeamBtn = dashBorder(button: createVersusButton("?", color: .white, centerX: Int(bound_width - bound_width / 4), centerY: yPos))
        } else {
            rightTeamBtn = createVersusButton(dataCenter.teams[rightTeamIdx].name, color: .red, centerX: Int(bound_width - bound_width / 4), centerY: yPos)
            rightTeamBtn.addTarget(self, action: #selector(clickRightTeam), for: .touchUpInside)
        }
        rightTeamBtn.tag = 2001
        
        let vsLabel = UILabel()
        vsLabel.text = "VS"
        vsLabel.frame.size = CGSize(width: 50, height: 50)
        vsLabel.textAlignment = .center
        vsLabel.textColor = .black
        vsLabel.font = UIFont.systemFont(ofSize: 30.0)
        vsLabel.center = CGPoint(x: Int(bound_width / 2), y: yPos)
        
        self.view.addSubview(vsLabel)
        self.view.addSubview(leftTeamBtn)
        self.view.addSubview(rightTeamBtn)
    }
    
    func drawStart() {
        let bound_width = self.view.bounds.width
        let bound_height = self.view.bounds.height
        let startBtn = UIButton()
        startBtn.setTitle("开始比赛", for: .normal)
        startBtn.frame.size = CGSize(width: Int(bound_width), height: 50)
        startBtn.setTitleColor(.black, for: .normal)
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 40.0)
        startBtn.center = CGPoint(x: Int(bound_width / 2), y: Int(bound_height - 80))
        self.view.addSubview(startBtn)
    }
    
    func createVersusButton(_ title: String, color: UIColor, centerX: Int, centerY: Int) -> UIButton {
        let button: UIButton = UIButton(type: .custom)
        button.frame.size = CGSize(width: 100, height: 100)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        button.center = CGPoint(x: centerX, y: centerY)
        return button
    }

    func createTeamButton(_ title: String, centerX: Int, centerY: Int) -> UIButton {
        let button: UIButton = UIButton(type: .custom)
        button.frame.size = CGSize(width: 250, height: 50)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10.0
        button.center = CGPoint(x: centerX, y: centerY)
        return button
    }
    
    func dashBorder(button: UIButton) -> UIButton {
        let lineWidth: CGFloat = 5.0
        let button_center = button.center
        button.frame.size = CGSize(width: button.frame.width - lineWidth, height: button.frame.height - lineWidth)
        button.center = button_center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50.0)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        
        let layer = CAShapeLayer.init()
        let path = UIBezierPath(roundedRect: button.frame,cornerRadius: button.layer.cornerRadius)
        layer.path = path.cgPath
        layer.strokeColor = UIColor.gray.cgColor
        layer.lineDashPattern = [10, 5]
        layer.lineWidth = lineWidth
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.clear.cgColor
        self.view.layer.addSublayer(layer)
        return button
    }
    
    @objc func clickTeam(teamBtn: UIButton) {
        let tag = teamBtn.tag - 1000
        if leftTeamIdx == tag || rightTeamIdx == tag {
            return
        }
        
        if leftTeamIdx == -1 {
            leftTeamIdx = tag
        } else if rightTeamIdx == -1 {
            rightTeamIdx = tag
        } else {
            return
        }
        
        updateView()
    }
    
    @objc func clickLeftTeam() {
        leftTeamIdx = -1
        updateView()
    }
    
    @objc func clickRightTeam() {
        rightTeamIdx = -1
        updateView()
    }
    
    @objc func clickAddTeam() {
//        dataCenter.addTeam("森林狼队")
//        updateView()
        let editTeamViewController = EditTeamViewController()
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.pushViewController(editTeamViewController, animated: true)
    }
    
    @objc func jumpToEditTeam() {
        let editTeamViewController = EditTeamViewController()
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.pushViewController(editTeamViewController, animated: false)
//        present(editTeamViewController, animated: true)
    }
}
