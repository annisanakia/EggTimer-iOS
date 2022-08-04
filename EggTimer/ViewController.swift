//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player:  AVAudioPlayer!
    let eggTimes = ["Soft":5, "Medium":7, "Hard":12]
    var eggTime = 0
    var secondsRemaining = 0
    var timer = Timer()
    var indexProgressBar = 0
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        timer.invalidate()
        indexProgressBar = 0
        titleLabel.text = hardness
        
        eggTime = eggTimes[hardness]!;
        secondsRemaining = eggTime;
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print("index \(indexProgressBar), seconds \(secondsRemaining)")
        getProgressBar()
        if(secondsRemaining > 0) {
            secondsRemaining -= 1
        }else{
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    func getProgressBar(){
        if indexProgressBar <= eggTime {
            progressBar.progress = Float(indexProgressBar) / Float(eggTime)
            indexProgressBar += 1
        }
    }
    
}
