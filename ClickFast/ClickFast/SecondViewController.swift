//
//  SecondViewController.swift
//  ButtonPressGame
//
//  Created by Berkin KABADAYI on 19.12.2020.
//


import UIKit

protocol SecondViewControllerDelegate: class {
    func updateLabels(clickscore : Int)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var infoLabel: UIStackView!
    @IBOutlet weak var numberLabel: UILabel!
    
    weak var delegate: SecondViewControllerDelegate?
    
    var timer: Timer?
    var isTimerOn = false
    var timeLeft = 5
    var clickCounter = 0
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - View Specs.
        // Button view specs.
        button.layer.cornerRadius = button.bounds.size.width/2
        // Info label specs.
        infoLabel.layer.cornerRadius = 20
        infoLabel.layer.masksToBounds = true
        // MARK: - Timer Start
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        highestScore = userDefaults.integer(forKey: "key")
    }
    // MARK: - Functions
    @IBAction func buttonClick(_ sender: Any) {
        
        clickCounter += 1
        numberLabel.text = " \(clickCounter)"
    }
    func startTimer() {
        
        isTimerOn = true
        if isTimerOn && timeLeft != 0 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatetimerLabel), userInfo: nil, repeats: true)
        }
    }
    
    func calculateHighestClick () {
        if clickCounter > highestScore {
            highestScore = clickCounter
        }
    }
    
    @objc func updatetimerLabel() {
        
        if timeLeft != 0 {
            timerLabel.text = "You have \(timeLeft) seconds left!"
            timeLeft -= 1
        } else {
            calculateHighestClick()
            timerLabel.text = "Game Over"
            timer?.invalidate()
            timer = nil
            let alertNewHighscore = UIAlertController(title: "Game Over", message: "Your time is done!", preferredStyle: .alert)
            updateLabels(clickScore: self.clickCounter)
            savingHighScore()
            alertNewHighscore.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.goToFirstVC()}))
            self.present(alertNewHighscore, animated: true)
            
        }
    }
    
    func updateLabels (clickScore : Int){
        self.delegate?.updateLabels(clickscore : highestScore)
    }
    
    func goToFirstVC () {
        self.navigationController?.popViewController(animated: true)
    }
    
    func savingHighScore()  {
        let savedScore = highestScore
        let userDefaults = UserDefaults.standard
        userDefaults.set(savedScore, forKey: "key")
    }
}
