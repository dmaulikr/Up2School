//
//  ReportViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit
import MessageUI

class ReportViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var academicImage1: UIImageView!
    @IBOutlet weak var academicImage2: UIImageView!
    @IBOutlet weak var academicImage3: UIImageView!
    @IBOutlet weak var academicImage4: UIImageView!
    @IBOutlet weak var academicImage5: UIImageView!

    @IBOutlet weak var emotionalImage1: UIImageView!
    @IBOutlet weak var emotionalImage2: UIImageView!
    @IBOutlet weak var emotionalImage3: UIImageView!
    @IBOutlet weak var emotionalImage4: UIImageView!
    @IBOutlet weak var emotionalImage5: UIImageView!

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    var pageIndex: Int!
    var report: Report?
    var teacher: String?

    var teacherPhone: String? {
        guard let teacher = teacher else { return nil }
        return LoginManager.users.lazy.filter { "\($0.lastName) \($0.firstName)" == teacher }.first?.phoneNumber
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAcademicActivity()
        configureLabels()
    }

    @IBAction func messageTeacher(_ sender: Any) {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        composeVC.recipients = teacherPhone.flatMap { [$0] } ?? []
        composeVC.body = teacher.flatMap { "Thank you \($0)" }

        present(composeVC, animated: true, completion: nil)
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

    private func configureLabels() {
        guard let report = report else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: report.date)
        messageTextView.text = report.comment
    }

    private func configureAcademicActivity() {
        guard let report = report else { return }
        academicImage1.image = report.academicRating.rawValue >= 1 ? #imageLiteral(resourceName: "academic_filled") : #imageLiteral(resourceName: "academic_empty")
        academicImage2.image = report.academicRating.rawValue >= 2 ? #imageLiteral(resourceName: "academic_filled") : #imageLiteral(resourceName: "academic_empty")
        academicImage3.image = report.academicRating.rawValue >= 3 ? #imageLiteral(resourceName: "academic_filled") : #imageLiteral(resourceName: "academic_empty")
        academicImage4.image = report.academicRating.rawValue >= 4 ? #imageLiteral(resourceName: "academic_filled") : #imageLiteral(resourceName: "academic_empty")
        academicImage5.image = report.academicRating.rawValue >= 5 ? #imageLiteral(resourceName: "academic_filled") : #imageLiteral(resourceName: "academic_empty")

        emotionalImage1.image = report.emotionalRating.rawValue >= 1 ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart_empty")
        emotionalImage2.image = report.emotionalRating.rawValue >= 2 ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart_empty")
        emotionalImage3.image = report.emotionalRating.rawValue >= 3 ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart_empty")
        emotionalImage4.image = report.emotionalRating.rawValue >= 4 ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart_empty")
        emotionalImage5.image = report.emotionalRating.rawValue >= 5 ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart_empty")
    }
}
