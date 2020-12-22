//
//  ViewController.swift
//  ButtonPressGame
//
//  Created by Berkin KABADAYI on 19.12.2020.
//

//ilk ödev: icon + launch screen olacak, 2 sayfa olacak birincisinde high score’lar ve başla butonu olacak, ikinci sayfada da bi tane timer(60dan geriye), bi tane buton, bi tane label (label’da butona kaç kere bastıysak yazacak)

//

import UIKit
import Foundation


class ViewController: UIViewController, SecondViewControllerDelegate {
    // MARK: - View Specs.
    // startButton view specs.
    @IBOutlet weak var startButton: UIButton!
    // Label views specs.
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var gameIntro: UILabel!
    
//    let targetSavings = "targetSavings"
//    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.layer.cornerRadius = 15
        topLabel.layer.masksToBounds = true
        
        stackView.layer.cornerRadius = 15
        stackView.layer.masksToBounds = true
        
        firstLabel.layer.cornerRadius = 15
        firstLabel.layer.masksToBounds = true
        
        secondLabel.layer.cornerRadius = 15
        secondLabel.layer.masksToBounds = true
        
        thirdLabel.layer.cornerRadius = 15
        thirdLabel.layer.masksToBounds = true
        
        fourthLabel.layer.cornerRadius = 15
        fourthLabel.layer.masksToBounds = true
        
        fifthLabel.layer.cornerRadius = 15
        fifthLabel.layer.masksToBounds = true
        
        gameIntro.layer.cornerRadius = 25
        gameIntro.layer.masksToBounds = true
        
        startButton.layer.cornerRadius = 15
        startButton.layer.masksToBounds = true
        
//        if let counterSave = userDefaults.value(forKey: targetSavings) as? String {
//            firstLabel.text = counterSave
        }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.integer(forKey: "key")
        firstLabel.text = "1- \(value) click in 60 sec"
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        secondViewController.delegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func updateLabels(clickscore : Int) {
        firstLabel.text = "1- \(clickscore) click in 60 sec"
    }
    
//    func saveUpdateLabels () {
//        userDefaults.setValue(firstLabel.text, forKey: targetSavings)
//        userDefaults.synchronize()
//        firstLabel.resignFirstResponder()
//    }
}

