//
//  StartViewController.swift
//  werewords
//
//  Created by 胡明昊工作Mac on 2019/10/21.
//  Copyright © 2019年 hmh. All rights reserved.
//

import UIKit

class StartViewController: GoHomeViewController {
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var wolfLabel: UILabel!
    @IBOutlet weak var prophetLabel: UILabel!
    @IBOutlet weak var villagerLabel: UILabel!
    
    @IBOutlet weak var wolfNumStepper: UIStepper!
    @IBOutlet weak var playerNumSlider: UISlider!
    
    var playerNum: Int! = 5
    var wolfNum: Int! = 1
    var prophetNum: Int! = 1
    var villagerNum: Int!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        playerNumSlider.value = Float(playerNum!)
        wolfNumStepper.value = Double(wolfNum!)
        updateNum()
    }
    
    func updateNum() {
        villagerNum = playerNum - wolfNum - prophetNum
        
        playerLabel.text = "人数：\(String(describing: playerNum!))"
        wolfLabel.text = "狼人：\(String(describing: wolfNum!))"
        prophetLabel.text = "先知：\(String(describing: prophetNum!))"
        villagerLabel.text = "村民：\(String(describing: villagerNum!))"
    }
    
    @IBAction func wolfNumStepperChanged(stepper: UIStepper) {
        wolfNum = Int(stepper.value)
        updateNum()
    }
    
    @IBAction func playerNumSliderChanged(slider: UISlider) {
        playerNum = Int(round(slider.value))
        updateNum()
    }
    
    func assignPos() -> (identities: [String], masterPos: Int) {
        // position starts at 0, ends at playerNum - 1
        var pos = Array<Int>()
        pos.append(contentsOf: 0 ..< playerNum!)
        let randPositions = pos.sample(size: prophetNum! + wolfNum!, noRepeat: true)!
        let masterPos = pos.sample!
        var identities = Array<String>(repeating: "村民", count: playerNum!)
        for randPosition in randPositions {
            identities[randPosition] = "狼人"
        }
        identities[randPositions[0]] = "先知"
        
        return (identities, masterPos)
    }
    
    @IBAction func jumpToAssignMaster(_ sender: UIButton) {
        let assignMasterViewController = self.storyboard?.instantiateViewController(withIdentifier: "AssignMasterViewController") as! AssignMasterViewController
        
        let result = assignPos()
        assignMasterViewController.identities = result.identities
        assignMasterViewController.masterPos = result.masterPos
        present(assignMasterViewController, animated: false)
    }    
}
