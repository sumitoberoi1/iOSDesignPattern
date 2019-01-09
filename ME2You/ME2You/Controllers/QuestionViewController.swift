//
//  ViewController.swift
//  ME2You
//
//  Created by sumit oberoi on 1/8/19.
//  Copyright © 2019 sumit oberoi. All rights reserved.
//

import UIKit

public protocol QuestionViewControllerDelegate:class {
    func questionViewController(_ viewController:QuestionViewController,
                                didCancel questionGroup:QuestionGroup,atQuestionIndex index:Int)
    func questionViewController(_ viewController:QuestionViewController,
                                didComplete questionGroup:QuestionGroup)
}
public class QuestionViewController: UIViewController {
    public var questionGroup:QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    private lazy var questionIndexItem:UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    public var questionView: QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    public weak var delegate:QuestionViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        questionIndexItem.title = "\(questionIndex + 1)/\(questionGroup.questions.count)"
    }
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self,
                                                           action: action)
    }
    
    @objc private func handleCancelPressed(sender:UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionGroup,
                                         atQuestionIndex: questionIndex)
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
            delegate?.questionViewController(self, didComplete: questionGroup)
        }
    }
}

