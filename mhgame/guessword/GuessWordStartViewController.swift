//
//  GuessWordStartViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/24.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class GuessWordStartViewController: GoHomeViewController {
    
    var classes: [UIButton] = []
    var choosedClassTag: Int! = 0
    
    let classLabels = ["所有词汇", "IT", "地名", "食物", "名人", "医疗", "成语"]
    let classPaths = ["all", "THUOCL_it", "THUOCL_diming", "THUOCL_food", "THUOCL_lishimingren", "THUOCL_medical", "THUOCL_chengyu"]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addClasses()
    }
    @IBAction func jumpToPlaying(_ sender: Any) {
        let guessWordPlayingViewController = self.storyboard?.instantiateViewController(withIdentifier: "GuessWordPlayingViewController") as! GuessWordPlayingViewController
        
        // read dataset
        var wordArray = [String]()
        if choosedClassTag == 0 {
            for i in 1 ..< classPaths.count {
                wordArray.append(contentsOf: readTxt(path: classPaths[i]))
            }
        } else {
            wordArray = readTxt(path: classPaths[choosedClassTag!])
        }
        
        guessWordPlayingViewController.dataset = wordArray
        present(guessWordPlayingViewController, animated: false)
    }
    
    func readTxt(path: String) -> [String]{
        var wordArray = [String]()
        if let txtFile = Bundle.main.path(forResource: path, ofType: "txt") {
            let txtData = NSData(contentsOfFile: txtFile)
            let myString:String = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
            wordArray = myString.components(separatedBy: "\n")
        }
        return wordArray
    }
    
    func addClass(title: String, i: Int) {
        let yPos = 150 + i * 50
        let clazz = UIButton(frame:CGRect(x: 0, y: yPos, width: 375, height: 42))
        clazz.setTitle(title, for: .normal)
        clazz.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        clazz.tag = i
        clazz.backgroundColor = .white
        if i == 0 {
            clazz.setTitleColor(.red, for: .normal)
        } else {
            clazz.setTitleColor(.gray, for: .normal)
        }
        clazz.addTarget(self, action: #selector(selectClass(clazz:)), for: .touchUpInside)
        self.view.addSubview(clazz)
        classes.append(clazz)
    }
    
    @objc func selectClass(clazz: UIButton) {
        for tmp in classes {
            tmp.setTitleColor(.gray, for: .normal)
        }
        clazz.setTitleColor(.red, for: .normal)
        choosedClassTag = clazz.tag
    }
    
    func addClasses() {
        for i in 0 ..< classLabels.count {
            addClass(title: classLabels[i], i: i)
        }
    }
}

