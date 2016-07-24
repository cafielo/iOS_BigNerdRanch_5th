//
//  ViewController.swift
//  chap1
//
//  Created by Joonwon Lee on 7/13/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
   
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
  
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?", "What is 7+7?", "What is capital of Vermont"]
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    var currentQuestIndex: Int = 0
}

//private 
private extension ViewController {
    private func animateLabelTransitions() {
        view.layoutIfNeeded()
        
        let screenWidth =  view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 3,
            options: [],
            animations: {
                self.nextQuestionLabel.alpha = 1
                self.currentQuestionLabel.alpha = 0
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
        })
    }
    
    private func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
}

//UIViewController
extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestIndex]
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
}

//IBAction
extension ViewController {
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestIndex += 1
        if currentQuestIndex == questions.count {
            currentQuestIndex = 0
        }
        
        let question: String = questions[currentQuestIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestIndex]
        answerLabel.text = answer
    }
}

