//
//  ChooseWordViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/22.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class ChooseWordViewController: GameRunViewController {
    
    @IBOutlet weak var identityLabel: UILabel!
    
    var masterPos: Int!
    var curPos: Int!
    var words: [UIButton] = []
    var magicWord: String?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addWords()
        identityLabel.text = identities![curPos!]
    }
    
    @IBAction func jumpToAfterReveal(_ sender: Any) {
        if magicWord != nil {
            let afterRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "AfterRevealViewController") as! AfterRevealViewController
            afterRevealViewController.identities = identities
            afterRevealViewController.masterPos = masterPos
            afterRevealViewController.curPos = curPos
            afterRevealViewController.magicWord = magicWord
            present(afterRevealViewController, animated: false)
        } else {
            let alert = UIAlertController(title: "请选择一个魔法咒语", message: "点击魔法咒语进行选择", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

    func readWordArray() -> ([String]) {
        var wordArray = [String]()
        if let txtFile = Bundle.main.path(forResource: "words", ofType: "txt") {
            let txtData = NSData(contentsOfFile: txtFile)
            let myString:String = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
            wordArray = myString.components(separatedBy: "\n")
        }
        return wordArray
//        return ["哈哈", "嘻嘻", "呵呵", "嘿嘿", "吼吼", "呼呼"]
    }
    
    func addWord(title: String, yPos: Int) {
        let word = UIButton(frame:CGRect(x: 0, y: yPos, width: 375, height: 42));
        word.setTitle(title, for: .normal)
        word.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        word.backgroundColor = .white
        word.setTitleColor(.gray, for: .normal)
        word.addTarget(self, action: #selector(selectWord(word:)), for: .touchUpInside)
        self.view.addSubview(word)
        words.append(word)
    }
    
    @objc func selectWord(word: UIButton) {
        for tmp in words {
            tmp.setTitleColor(.gray, for: .normal)
        }
        word.setTitleColor(.red, for: .normal)
        magicWord = word.currentTitle
    }
    
    func addWords() {
        let wordNum = 3
        let allWordArray = readWordArray()
        let candidates = allWordArray.sample(size: wordNum, noRepeat: true)!
        for i in 0 ..< wordNum {
            addWord(title: candidates[i], yPos: 300 + i * 50)
        }
    }
    
}
