//
//  ViewController.swift
//  DinosaurGame
//
//  Created by Le Ngoc Phu on 09/06/2022.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var grassView: UIView!
    @IBOutlet weak var dinosaurImage: UIImageView!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    
    var dinosaur: Dinosaur?
    var object: Object?
    var screenWidth:CGFloat?
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        grassView.backgroundColor = UIColor(patternImage: UIImage(named: "Grass")!)
        
        screenWidth = view.frame.width
        
        initCharacterAndObject()
    }

    @IBAction func clickBackground(_ sender: UIButton) {
        dinosaur?.timerDinosaur.invalidate()
        dinosaur?.dinosaurJump()
    }
    
    @IBAction func clickPlayAgain(_ sender: Any) {
        initCharacterAndObject()
    }
    
    @IBAction func clickHomeButton(_ sender: Any) {
        gotoHome()
    }
    
    func initCharacterAndObject(){
        //---SCORE LABEL---
        scoreLabel.text = "0"
        
        //---PLAY AGAIN ---
        gameOverLabel.isHidden = true
        playAgainButton.isHidden = true
        
        //---HOME---
        homeButton.isHidden = true
        
        //---DINOSAUR---
        dinosaur = Dinosaur (img: dinosaurImage)
        dinosaur?.dinosaurRun()
        
        //---OBJECT---
        object = Object(imgO: objectImage, character: self.dinosaur! ,width: screenWidth!, label: scoreLabel, button: playAgainButton, gameOver: gameOverLabel, home: homeButton)
        object?.timerObject?.invalidate()
        object?.objectMoveLeft()
    }
    
    func gotoHome(){
        self.navigationController?.popViewController(animated: true)
    }
}

