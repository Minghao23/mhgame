//
//  HomeViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/22.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
//
//    func jumpToStart(playerNum: Int, wolfNum: Int) {
//        let startViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
//
//        startViewController.playerNum = playerNum
//        startViewController.wolfNum = wolfNum
//        self.navigationController?.pushViewController(startViewController , animated: false)
//    }
    
}

extension Array {
    
    public var sample: Element? {
        guard count > 0 else { return nil }
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
    
    public func sample(size: Int, noRepeat: Bool = false) -> [Element]? {
        guard !isEmpty else { return nil }
        
        var sampleElements: [Element] = []
        if !noRepeat {
            for _ in 0..<size {
                sampleElements.append(sample!)
            }
        }
        else{
            var copy = self.map { $0 }
            for _ in 0..<size {
                if copy.isEmpty { break }
                let randomIndex = Int(arc4random_uniform(UInt32(copy.count)))
                let element = copy[randomIndex]
                sampleElements.append(element)
                copy.remove(at: randomIndex)
            }
        }
        
        return sampleElements
    }
}

