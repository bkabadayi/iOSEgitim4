//
//  SecondViewController.swift
//  ButtonPressGame
//
//  Created by Berkin KABADAYI on 19.12.2020.
//


import UIKit

protocol SecondViewControllerDelegate: class {
    func updateLabels(clickscore : [Int])
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
    var clickCounterArray : [Int] = [0, 0, 0, 0, 0]
    
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
    // MARK: - Functions
    @IBAction func buttonClick(_ sender: Any) {
        
        clickCounter += 1
        numberLabel.text = " \(clickCounter)"
    }
    func startTimer() {
        
        isTimerOn = true
        if isTimerOn && timeLeft != 0 {
            timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(updatetimerLabel), userInfo: nil, repeats: true)
        }
    }
    
    func calculateHighestClick () {
        clickCounterArray.append(clickCounter)
        clickCounterArray.sort(by: {$0 > $1})
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
            alertNewHighscore.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.updateLabels(clickScore: self.clickCounterArray)}))
            self.present(alertNewHighscore, animated: true)
            
        }
    }
    func updateLabels (clickScore : [Int]){
        
        self.delegate?.updateLabels(clickscore : clickCounterArray)
        self.navigationController?.popViewController(animated: true)
    }
}
