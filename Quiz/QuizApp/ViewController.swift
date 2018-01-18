//
//  ViewController.swift
//  QuizApp
//
//  Created by Raaj on 1/5/18.
//  Copyright © 2018 RVK. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CountdownTimerDelegate {

    struct Question {
        let question: String
        let answers: [String]
        let correctAnswer: Int
        var isAnswered: Bool
        let questionNumber: Int
    }
    
    
    var questions: [Question] = [
        Question(
            question: "What is Capital of India?",
            answers: ["Bengaluru", "Kolkata", "Delhi", "Mumbai"],
            correctAnswer: 2,
            isAnswered: false,
            questionNumber: 1),
        Question(
            question: "What is payload size of Push Notifications",
            answers: ["1KB", "2KB", "3KB", "4KB"],
            correctAnswer: 1,
            isAnswered: false,
            questionNumber: 2),
        Question(
            question: "Which of the following is not a state in lifecyle of a Service?",
            answers: ["Starting", "Running", "Destroyed", "Paused"],
            correctAnswer: 3,
            isAnswered: false,
            questionNumber: 3),
        Question(
            question: "What is among the build phases available in Xcode?",
            answers: ["Compile Suurces", "Link Binary Lib", "Copy Bundle resources", "Clean Project"],
            correctAnswer: 3,
            isAnswered: false,
            questionNumber: 4),
        Question(
            question: "What is payload size of Push Notifications",
            answers: ["1KB", "2KB", "3KB", "4KB"],
            correctAnswer: 1,
            isAnswered: false,
            questionNumber: 5),
        Question(
            question: "Which of the following is not a state in lifecyle of a Service?",
            answers: ["Starting", "Running", "Destroyed", "Paused"],
            correctAnswer: 3,
            isAnswered: false,
            questionNumber: 6),
        Question(
            question: "Types of Swift properties are?",
            answers: ["Stored", "Computed", "Both", "None"],
            correctAnswer: 2,
            isAnswered: false,
            questionNumber: 7),
        Question(
            question: "Which is 'group multiple values in a single compound Value'.",
            answers: ["Tuples", "Int", "Var", "Gaurd"],
            correctAnswer: 0,
            isAnswered: false,
            questionNumber: 8),
        Question(
            question: "Which of the following is not a state in lifecyle of a Service?",
            answers: ["Starting", "Running", "Destroyed", "Paused"],
            correctAnswer: 3,
            isAnswered: false,
            questionNumber: 9),
        Question(
            question: "Swift Control statements are?",
            answers: ["Break", "Continue", "Fallthrough", "All"],
            correctAnswer: 3,
            isAnswered: false,
            questionNumber: 10),

    ]
    
    var currentQuestion: Question?
    var currentQuestionPos = 0
    var isAnsweredFlag = false
    var noCorrect = 0
    static var wrongNum = 0
    
    //Outlets declaration
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPrevQ: UIButton!
    @IBOutlet weak var btnNextQ: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    //Timer Labels

    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var counterView: UIStackView!

    //Multi Choices & Question
    @IBOutlet var lblQuestion: UITextView!
    @IBOutlet var answer0: UIButton!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var lblProgress: UILabel!
    
    
    var countdownTimerDidStart = false
    
     var countdownTimer: CountdownTimer = {
        let countdownTimer = CountdownTimer()
        return countdownTimer
    }()
    
    let selectedSecs:Int = 600 //Setting 10 mins timer

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //timer
        countdownTimer.delegate = self
        countdownTimer.setTimer(minutes: 0, seconds: selectedSecs)
        self.btnStartClicked(btnStart)
        //test
        currentQuestion = questions[0]
        setQuestion()
    
    }
    
    //set time
    func countdownTime(time: (minutes: String, seconds: String)) {
        minutes.text = time.minutes
        seconds.text = time.seconds
    }
    func countdownTimerDone() {
        
        counterView.isHidden = true
        seconds.text = String(selectedSecs)
        countdownTimerDidStart = false
        btnStop.isEnabled = false
        btnStop.alpha = 0.5
        btnStart.isEnabled = false
        
        let alert = UIAlertController(title: "Alert", message: "Your time is out", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "sgShowResults", sender: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    // Submit an answer
    @IBAction func submitAnswer0(_ sender: Any) {
        if(checkAnswer(idx: 0)){
          
            answer0.backgroundColor = UIColor.green
            //answer0.backgroundColor = UIColor.init(colorLiteralRed: (100/255), green: (150/255), blue: (200/255), alpha: 1)

        }else{
            answer0.backgroundColor = UIColor.red

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.loadNextQuestion()
        })
        
    }
    
    @IBAction func submitAnswer1(_ sender: Any) {
        if(checkAnswer(idx: 1)){
            
            answer1.backgroundColor = UIColor.green
            //answer0.backgroundColor = UIColor.init(colorLiteralRed: (100/255), green: (150/255), blue: (200/255), alpha: 1)
            
            }else{
                answer1.backgroundColor = UIColor.red
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.loadNextQuestion()
            })
            
        }
    
    @IBAction func submitAnswer2(_ sender: Any) {
        if(checkAnswer(idx: 2)){
            
            answer2.backgroundColor = UIColor.green
            //answer0.backgroundColor = UIColor.init(colorLiteralRed: (100/255), green: (150/255), blue: (200/255), alpha: 1)
            
        }else{
            answer2.backgroundColor = UIColor.red
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.loadNextQuestion()
        })
        
    }
    @IBAction func submitAnswer3(_ sender: Any) {
        if(checkAnswer(idx: 3)){
            
            answer3.backgroundColor = UIColor.green
            
        }else{
            answer3.backgroundColor = UIColor.red
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.loadNextQuestion()
        })
        
    }
   
    
    @IBAction func btnSubmitClicked(_ sender: AnyObject) {
        
        let submitAlert = UIAlertController(title: "Alert", message: "Do you want to submit the test ?", preferredStyle: UIAlertControllerStyle.alert)
        
        submitAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "sgShowResults", sender: nil)
        }))
        
        submitAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(submitAlert, animated: true, completion: nil)
        
    }

  
    
    //Question and buttons with Choices for the current question
    func setQuestion() {
        lblQuestion.text = currentQuestion!.question
        answer0.setTitle(currentQuestion!.answers[0], for: .normal)
        answer1.setTitle(currentQuestion!.answers[1], for: .normal)
        answer2.setTitle(currentQuestion!.answers[2], for: .normal)
        answer3.setTitle(currentQuestion!.answers[3], for: .normal)
        lblProgress.text = "\(currentQuestionPos+1) / \(questions.count)"
        isAnsweredFlag = (currentQuestion?.isAnswered)!
        
    }
    
    // Check if an answer is correct then load the next question
    
    func checkAnswer(idx: Int) -> (Bool) {
        if(idx == currentQuestion!.correctAnswer) {
            noCorrect += 1
            currentQuestion!.isAnswered = true
            return true
        }
        else{
            ViewController.wrongNum += 1
            return false
        }
    }

    
    func loadNextQuestion() {
        // next question
        answer0.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer1.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer2.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer3.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        
        
        if(currentQuestionPos + 1 < questions.count) {
            currentQuestionPos += 1
            currentQuestion = questions[currentQuestionPos]
            setQuestion()
        
            // no more questions show result
        } else {
            performSegue(withIdentifier: "sgShowResults", sender: nil)
        }
        

    }
    @IBAction func btnNextClicked(_ sender: AnyObject) {
        
        btnPrevQ.isEnabled = true
        
        answer0.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer1.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer2.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer3.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        
        
        if(currentQuestionPos + 1 < questions.count) {
            currentQuestionPos += 1
            currentQuestion = questions[currentQuestionPos]
            setQuestion()
            
            // no more questions show result
        } else {
            
            let submitAlert = UIAlertController(title: "Alert", message: "Do you want to submit the test ?", preferredStyle: UIAlertControllerStyle.alert)
            
            submitAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.performSegue(withIdentifier: "sgShowResults", sender: nil)
            }))
            
            submitAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(submitAlert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func btnPrevClicked(_ sender: AnyObject) {
        
        btnNextQ.isEnabled = true
        answer0.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer1.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer2.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        answer3.backgroundColor = UIColor.init(colorLiteralRed: (102/255), green: (204/255), blue: (255/255), alpha: 1)
        
        
        if(currentQuestionPos > 0) {
            currentQuestionPos -= 1
            currentQuestion = questions[currentQuestionPos]
            setQuestion()
            
            // no more questions show result
        } else {
            
            btnPrevQ.isEnabled = false
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sgShowResults") {
            var vc = segue.destination as! ResultsViewController
            vc.noCorrect = noCorrect
            vc.wrongNum = ViewController.wrongNum
            vc.total = questions.count
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnStartClicked(_ sender: UIButton) {
        
        counterView.isHidden = false
        
        btnStop.isEnabled = true
        btnStop.alpha = 1.0
        answer0.isEnabled = true
        answer1.isEnabled = true
        answer2.isEnabled = true
        answer3.isEnabled = true
        btnNextQ.isEnabled = true
        btnPrevQ.isEnabled = true
        answer0.alpha = 1.0
        answer1.alpha = 1.0
        answer2.alpha = 1.0
        answer3.alpha = 1.0
        btnPrevQ.alpha = 1.0
        btnNextQ.alpha = 1.0

        
        if !countdownTimerDidStart{
            countdownTimer.start()
            countdownTimerDidStart = true
        }
    }
    
    @IBAction func btnStopCliked(_ sender: AnyObject) {
        
        countdownTimer.pause()
        countdownTimerDidStart = false
        btnStop.isEnabled = false
        btnStart.isEnabled = true
        answer0.isEnabled = false
        answer1.isEnabled = false
        answer2.isEnabled = false
        answer3.isEnabled = false
        btnNextQ.isEnabled = false
        btnPrevQ.isEnabled = false
        answer0.alpha = 1.0
        answer1.alpha = 1.0
        answer2.alpha = 1.0
        answer3.alpha = 1.0
        btnPrevQ.alpha = 1.0
        btnNextQ.alpha = 1.0
        
    }
    

}

