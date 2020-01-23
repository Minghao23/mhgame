//
//  SchulteGridStartViewController.swift
//  mhgame
//
//  Created by 胡明昊工作Mac on 2020/1/8.
//  Copyright © 2020年 hmh. All rights reserved.
//

import UIKit

class SchulteGridStartViewController: GoHomeViewController {
    
    let grid_row_num: Int = 5
    let grid_col_num: Int = 5
    
    var current_tag = -1
    var timer = Timer()
    var counter = 0.0
    var timeLabel = UILabel()
    
    let startBtn = UIButton()
    let maskBtn = UIButton()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        drawStart()
        drawRankButton()
        drawTimeLabel()
        drawGirds()
    }
    
    func drawGirds() {
        var numbers: [Int] = []
        numbers.append(contentsOf: 1...(grid_row_num * grid_col_num))
        numbers.shuffle()
        
        let bound_width = self.view.bounds.width
        let total_width = bound_width * 0.8
        let grid_width = total_width / CGFloat(grid_col_num)
        let half_grid_width = grid_width / 2
        let right_margin = bound_width * 0.1
        let top_margin: CGFloat = 100
        
        var index: Int = 0
        for i in 0 ..< grid_row_num {
            for j in 0 ..< grid_col_num {
                let grid = createGridButton(String(numbers[index]),
                                            centerX: Int(right_margin + CGFloat(j) * grid_width + half_grid_width),
                                            centerY: Int(top_margin + CGFloat(i) * grid_width + half_grid_width),
                                            grid_width: grid_width)
                grid.tag = numbers[index]
                grid.addTarget(self, action: #selector(clickGridDown(btn:)), for: .touchDown)
                grid.addTarget(self, action: #selector(clickGridUp(btn:)), for: .touchUpInside)
                self.view.addSubview(grid)
                index = index + 1
            }
        }
        
        // draw grid mask
        maskBtn.frame.size = CGSize(width: total_width, height: total_width)
        maskBtn.setTitle("?", for: .normal)
        maskBtn.setTitleColor(.white, for: .normal)
        maskBtn.backgroundColor = .gray
        maskBtn.titleLabel?.font = UIFont.systemFont(ofSize: 80.0)
        maskBtn.layer.borderWidth = 2
        maskBtn.center = CGPoint(x: Int(right_margin + total_width / 2), y: Int(top_margin + total_width / 2))
        self.view.addSubview(maskBtn)
    }
    
    func createGridButton(_ title: String, centerX: Int, centerY: Int, grid_width: CGFloat) -> UIButton {
        let button: UIButton = UIButton(type: .custom)
        button.frame.size = CGSize(width: grid_width, height: grid_width)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.layer.borderWidth = 1
        button.center = CGPoint(x: centerX, y: centerY)
        return button
    }
    
    @objc func clickGridDown(btn: UIButton) {
        if btn.tag == current_tag + 1 {
            btn.backgroundColor = .green
            current_tag = current_tag + 1
        }
        else {
            btn.backgroundColor = .red
        }
        if current_tag == grid_row_num * grid_col_num {
            end()
        }
    }
    
    @objc func clickGridUp(btn: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            btn.backgroundColor = .white
        }

    }
    
    func drawStart() {
        let bound_width = self.view.bounds.width
        let bound_height = self.view.bounds.height
        startBtn.setTitle("Start", for: .normal)
        startBtn.backgroundColor = UIColor.init(red: 100/255.0, green: 230/255.0, blue: 100/255.0, alpha: 1)
        startBtn.frame.size = CGSize(width: Int(bound_width / 2), height: 70)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 40.0)
        startBtn.center = CGPoint(x: Int(bound_width / 2), y: Int(bound_height - 100))
        startBtn.layer.masksToBounds = true
        startBtn.layer.cornerRadius = 15.0
        startBtn.addTarget(self, action: #selector(clickStart), for: .touchUpInside)
        self.view.addSubview(startBtn)
    }
    
    func drawTimeLabel() {
        let bound_width = self.view.bounds.width
        let bound_height = self.view.bounds.height
        timeLabel = UILabel()
        timeLabel.text = "0.00"
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 60.0)
        timeLabel.frame = CGRect(x: 0, y: Int(bound_height - 230), width: Int(bound_width), height: 70)
        self.view.addSubview(timeLabel)
    }

    func end() {
        current_tag = -1
        startBtn.setTitle("Start", for: .normal)
        startBtn.backgroundColor = UIColor.init(red: 100/255.0, green: 230/255.0, blue: 100/255.0, alpha: 1)
        timer.invalidate()
    }
    
    @objc func clickStart() {
        if current_tag == -1 {
            current_tag = 0
            startBtn.setTitle("Reset", for: .normal)
            startBtn.backgroundColor = UIColor.init(red: 255/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
            maskBtn.alpha = 0
            resetTimer()
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        } else {
            current_tag = -1
            startBtn.setTitle("Start", for: .normal)
            startBtn.backgroundColor = UIColor.init(red: 100/255.0, green: 230/255.0, blue: 100/255.0, alpha: 1)
            maskBtn.alpha = 1
            timer.invalidate()
            resetTimer()
        }
    }
    
    @objc func updateTimer() {
        counter += 0.01
        timeLabel.text = String(format:"%.2f", counter)
    }
    
    func resetTimer() {
        counter = 0.0
        timeLabel.text = String(format:"%.2f", counter)
    }
    
    func drawRankButton() {
        let bound_width = self.view.bounds.width
        let rankBtn = UIButton(frame:CGRect(x: Int(bound_width - 120), y: 20, width: 100, height: 50))
        rankBtn.setTitle("排行榜", for: .normal)
        rankBtn.contentHorizontalAlignment = .right
        rankBtn.backgroundColor = .white
        rankBtn.setTitleColor(.gray, for: .normal)
        rankBtn.addTarget(self, action: #selector(jumpToRank), for: .touchUpInside)
        self.view.addSubview(rankBtn)
    }
    
    @objc func jumpToRank() {
        let rankViewController = self.storyboard?.instantiateViewController(withIdentifier: "RankViewController") as! RankViewController
        present(rankViewController, animated: false)
    }

}
