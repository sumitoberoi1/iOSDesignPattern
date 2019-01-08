//
//  ViewController.swift
//  ME2You
//
//  Created by sumit oberoi on 1/8/19.
//  Copyright © 2019 sumit oberoi. All rights reserved.
//

import UIKit

public class QuestionViewController: UIViewController {
    public var questionGroup = QuestionGroup.basicPhrases()
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
    }
    
    @IBAction func toggleAnswerLabels(_ sender:Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender:Any) {
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }
    
    @IBAction func handleInCorrect(_ sender:Any) {
        incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        if (questionIndex < questionGroup.questions.count) {
            showQuestion()
        } else {
            //TODO: Handle THis
        }
    }
}

