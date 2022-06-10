//
//  HomeViewController.swift
//  DinosaurGame
//
//  Created by Le Ngoc Phu on 10/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var dinosaurImage: UIImageView!
    @IBOutlet weak var grassView: UIView!
    var dinosaur:Dinosaur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        grassView.backgroundColor = UIColor(patternImage: UIImage(named: "Grass")!)
        
        dinosaur = Dinosaur(img: dinosaurImage)
        dinosaur?.timerDinosaur.invalidate()
        dinosaur?.dinosaurIdle()
    }
    
    @IBAction func clickPlayGame(_ sender: Any) {
        goToGamePlay()
    }
    
    func goToGamePlay(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let gamePlayScreen = sb.instantiateViewController(withIdentifier: "GAME") as! GameViewController
        self.navigationController?.pushViewController(gamePlayScreen, animated: true)
    }
    
}
