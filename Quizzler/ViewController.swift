//
//  ViewController.swift
//  Quizzler
//

//

import UIKit


class ViewController: UIViewController {
    
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    var questionBank = QuestionBank()
    var currentScore : Int = 0
    
    var givenAnswer : Bool = false
    var currentQuestionIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load first question to view
        questionLabel.text = questionBank.list[0].questionText
        scoreLabel.text = "Score:0"
        
        
        
    }
    
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            givenAnswer = true
        }
        else if sender.tag == 2 {
            givenAnswer = false
        }
        
        checkAnswer(givenAnswer: givenAnswer)
        
        if !(currentQuestionIndex >= questionBank.list.endIndex - 1){
            currentQuestionIndex += 1
            
        }
        else {
            
           let alert =  UIAlertController(title: "Quiz Finished", message: "Starting Over", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
        
        updateUI()
        
    }
    
    
    func updateUI() {
        questionLabel.text = questionBank.list[currentQuestionIndex].questionText
        progressLabel.text = String(currentQuestionIndex+1) + "/13"
        if currentQuestionIndex > 0 {
        progressBarWidthConstraint.constant = (self.view.frame.size.width/13) * CGFloat(currentQuestionIndex+1)
        progressBar.layoutIfNeeded()
        } else {
            progressBarWidthConstraint.constant = (self.view.frame.size.width/13)
            progressBar.layoutIfNeeded()
        }
    }
    
    func updateScore() {
        currentScore += 1
        scoreLabel.text = "Score:" + String(currentScore)
        
    }
    
    func nextQuestion() {
        
    }
    
    
    func checkAnswer(givenAnswer : Bool) {
        if givenAnswer == questionBank.list[currentQuestionIndex].answer {
            ProgressHUD.showSuccess("Correct")
            updateScore()
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
        currentQuestionIndex = 0
        progressBarWidthConstraint.constant = 5
        progressBar.layoutIfNeeded()
        updateUI()
        scoreLabel.text = "Score:0"
        
        
    }
    
    
    
}
