//
//  SelectQuestionGroupViewController.swift
//  ME2You
//
//  Created by sumit oberoi on 1/8/19.
//  Copyright © 2019 sumit oberoi. All rights reserved.
//

import UIKit


public class SelectQuestionGroupViewController:UIViewController {
    @IBOutlet internal var tableView:UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup:QuestionGroup!
}

extension SelectQuestionGroupViewController:UITableViewDataSource{
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell", for:indexPath) as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        return cell
    }
}

extension SelectQuestionGroupViewController:UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController {
            questionViewController.questionGroup = selectedQuestionGroup
            questionViewController.delegate = self
        }
    }
}

extension SelectQuestionGroupViewController:QuestionViewControllerDelegate {
    public func questionViewController(_ viewController: QuestionViewController,
                                       didCancel questionGroup: QuestionGroup,
                                       atQuestionIndex index: Int) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ viewController: QuestionViewController,
                                       didComplete questionGroup: QuestionGroup) {
        navigationController?.popToViewController(self, animated: true)
    }
    
}
