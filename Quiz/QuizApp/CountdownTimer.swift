//
//  CountdownTimer.swift
//  QuizApp
//
//  Created by Raaj on 1/5/18.
//  Copyright © 2018 RVK. All rights reserved.
//

import UIKit

protocol CountdownTimerDelegate:class {
    func countdownTimerDone()
    func countdownTime(time: (minutes:String, seconds:String))
}

class CountdownTimer {
    
    weak var delegate: CountdownTimerDelegate?
    
     var seconds = 0.0
     var duration = 0.0
    
    lazy var timer: Timer = {
        let timer = Timer()
        return timer
    }()
    
        func setTimer(minutes:Int, seconds:Int) {
        
        let minutesToSeconds = minutes * 60
        let secondsToSeconds = seconds
        
        let seconds = secondsToSeconds + minutesToSeconds
        self.seconds = Double(seconds)
        self.duration = Double(seconds)
        
        delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
    }
    
     func start() {
        runTimer()
    }
    
     func pause() {
        timer.invalidate()
    }
    
    func stop() {
        timer.invalidate()
        duration = seconds
        delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
    }
    
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer(){
        if duration <= 0.0 {
            timer.invalidate()
            timerDone()
        } else {
            duration -= 1.0
            delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
        }
    }
    
    private func timeString(time:TimeInterval) -> (minutes:String, seconds:String) {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return (minutes: String(format:"%02i", minutes), seconds: String(format:"%02i", seconds))
    }
    
    private func timerDone() {
        timer.invalidate()
        duration = seconds
        print("STOP Timer")
        delegate?.countdownTimerDone()
    }
    
}
