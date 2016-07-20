//
//  ViewController.swift
//  chap1
//
//  Created by Joonwon Lee on 7/13/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = ["From what is cognac made?", "What is 7+7?", "What is capital of Vermont"]
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    var currentQuestIndex: Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestIndex]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestIndex += 1
        if currentQuestIndex == questions.count {
            currentQuestIndex = 0
        }
        
        let question: String = questions[currentQuestIndex]
        questionLabel.text = question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestIndex]
        answerLabel.text = answer
    }
    
    
}

