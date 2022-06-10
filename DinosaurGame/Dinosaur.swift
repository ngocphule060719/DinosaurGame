//
//  Dinosaur.swift
//  DinosaurGame
//
//  Created by Le Ngoc Phu on 09/06/2022.
//

import Foundation
import UIKit

class Dinosaur {
    
    let runCounterMax = 7
    let jumpCounterMax = 11
    let deadCounterMax = 7
    let idleCounterMax = 9
    var counter = 0
    var timerDinosaur = Timer()
    var imgDinosaur:UIImageView?
    var currentPositionY:CGFloat?
    var dinosaurHeight:CGFloat?
    var positionYChange:CGFloat?
    
    init(img:UIImageView){
        self.imgDinosaur = img
        self.dinosaurHeight = (self.imgDinosaur?.frame.height)!
        self.positionYChange = dinosaurHeight!/CGFloat(jumpCounterMax - 4)
        self.currentPositionY = (imgDinosaur?.layer.position.y)!
    }
    
    func dinosaurIdle(){
        let q_idle = DispatchQueue(label: "dinosaur idle")
        counter = 0
        q_idle.async {
            DispatchQueue.self.main.async { [self] in
                timerDinosaur = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.dinosaurImgIdle), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func dinosaurImgIdle(){
        updateImg(actionName: "Idle")
    }
    
    func dinosaurRun(){
        let q_run = DispatchQueue(label: "dinosaur run")
        counter = 0
        q_run.async {
            DispatchQueue.self.main.async { [self] in
                timerDinosaur = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.dinosaurImgRun), userInfo: nil, repeats: true)
            }
        }
    }

    @objc func dinosaurImgRun(){
        updateImg(actionName: "Run")
    }
    
    func dinosaurJump(){
        let q_jump = DispatchQueue(label: "dinosaur jump")
        counter = 0
        q_jump.async {
            DispatchQueue.self.main.async { [self] in
                timerDinosaur = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(self.dinosaurImgJump), userInfo: nil, repeats: true)
            }
        }
    }

    @objc func dinosaurImgJump(){
        updatePosition()
        updateImg(actionName: "Jump")
    }
    
    func dinosaurDead(){
        let q_dead = DispatchQueue(label: "dinosaur dead")
        counter = 0
        q_dead.async {
            DispatchQueue.self.main.async { [self] in
                timerDinosaur = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.dinosaurImgDead), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func dinosaurImgDead(){
        updateImg(actionName: "Dead")
    }
    
    func updateImg(actionName: String){
        
        var counterMax = 0
        if actionName == "Run" {
            counterMax = runCounterMax
        } else if actionName == "Jump" {
            counterMax = jumpCounterMax
        } else if actionName == "Dead" {
            counterMax = deadCounterMax
        } else if actionName == "Idle" {
            counterMax = idleCounterMax
        }
        
        let imgString:String = actionName + " (\(counter + 1))"
        imgDinosaur?.image = UIImage(named: imgString)
        if counter < counterMax {
            counter += 1
        } else {
            counter = 0
            if actionName == "Jump" {
                timerDinosaur.invalidate()
                dinosaurRun()
            }
            if actionName == "Dead" {
                timerDinosaur.invalidate()
            }
        }
    }
    
    func updatePosition(){
        if counter < jumpCounterMax/2 + 1 {
            imgDinosaur?.layer.position.y = currentPositionY! - positionYChange!
        } else {
            imgDinosaur?.layer.position.y = currentPositionY! + positionYChange!
        }
        currentPositionY = (imgDinosaur?.layer.position.y)!
    }
    
}
