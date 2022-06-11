//
//  Object.swift
//  DinosaurGame
//
//  Created by Le Ngoc Phu on 09/06/2022.
//

import Foundation
import UIKit

class Object{
    
    let xDistance = 2
    let yDistance = 100
    
    var imgObject:UIImageView?
    var startPositionX:CGFloat?
    var xObject:CGFloat?
    var yObject:CGFloat?
    var objectHeight:CGFloat?
    var objectWidth:CGFloat?
    
    var dinosaur:Dinosaur?
    var xDinosaur:CGFloat?
    var yDinosaur:CGFloat?
    
    var score:Double = 0.0
    var scoreLabel: UILabel?
    
    var gameOverLabel:UILabel?
    var buttonPlayAgain:UIButton?
    var buttonHome:UIButton?
    
    let movingTimes = 200
    var timerObject:Timer?
    var screenWidth:CGFloat?
    let ObjectImage:[String] = ["Crate", "Sign", "Mushroom_2", "Mushroom_1"]
    
    
    init(imgO: UIImageView, character: Dinosaur, width: CGFloat, label: UILabel, button: UIButton, gameOver: UILabel, home: UIButton){
        self.imgObject = imgO
        self.screenWidth = width
        self.startPositionX = imgO.layer.position.x
        self.objectHeight = imgO.frame.height
        self.objectWidth = imgO.frame.width
        self.scoreLabel = label
        self.buttonPlayAgain = button
        self.gameOverLabel = gameOver
        self.buttonHome = home
        updatePosition(character: character, img: imgObject!)
    }
    
    func objectMoveLeft(){
        let q_ObjectMove = DispatchQueue(label: "object move left")
        q_ObjectMove.async {
            DispatchQueue.main.async {[self] in
                    self.timerObject = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.moveLeft), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func moveLeft(){
        let positionXChange = screenWidth!/CGFloat(movingTimes)
        if xObject! > CGFloat(0) {
            imgObject?.layer.position.x = xObject! - positionXChange
        } else {
            createNewObject()
            imgObject?.layer.position.x = startPositionX!
            updateScoreLabel()
        }
        self.xObject = imgObject?.layer.position.x
        updatePosition(character: dinosaur!, img: imgObject!)
        if (checkPosition()) {
            timerObject?.invalidate()
            dinosaur?.timerDinosaur.invalidate()
            dinosaur?.dinosaurDead()
            popUpPlayAgain()
        }
    }
    
    
    func createNewObject(){
        let randomImage:Int = Int.random(in: 0..<ObjectImage.count)
        self.imgObject?.image = UIImage(named: ObjectImage[randomImage])
    }
    
    func updatePosition(character: Dinosaur, img: UIImageView){
        self.dinosaur = character
        self.xDinosaur = dinosaur?.imgDinosaur?.layer.position.x
        self.yDinosaur = dinosaur?.imgDinosaur?.layer.position.y
        self.xObject = img.layer.position.x
        self.yObject = img.layer.position.y
    }
    
    func checkPosition() -> Bool{
        if abs(Int32(xObject! - xDinosaur!)) < xDistance || abs(Int32((xObject! + objectWidth!) - xDinosaur!)) < xDistance {
            if (yObject! - yDinosaur!) < objectHeight! {
                return true
            } else {
                score += 0.5
            }
        }
        return false
    }
    
    func updateScoreLabel(){
        self.scoreLabel?.text = String(format: "%.0f", score)
    }
    
    func popUpPlayAgain(){
        self.gameOverLabel?.isHidden = false
        self.buttonPlayAgain?.isHidden = false
        self.buttonHome?.isHidden = false
    }
    
}
