//
//  PlaceViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 11/4/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import UIKit

public protocol PlaceViewModelProtocol: class {
    func setViewController(_ viewController: PlaceViewControllerProtocol)
    func placeModelRequested()
    func updateCommentRequested(_ newCommentText: String)
}

fileprivate struct CellIdentifiers {
    static let placeTitleCell = "PlaceTitleCell"
    static let ratingCell = "RatingCell"
    static let goToCell = "GoToCell"
    static let commentCell = "CommentCell"
}

fileprivate enum CellIndexes: Int {
    case placeTitleCell
    case ratingCell
    case goToCell
    case commentCell
}

public class PlaceViewController: UIViewController, PlaceViewControllerProtocol {

    private var isEditable: Bool = false
    public func setIsEditable(_ isEditable: Bool) {
        self.isEditable = isEditable
    }

    private var placeName: String? {
        didSet {
            tableView.reloadRows(at: [IndexPath(row: CellIndexes.placeTitleCell.rawValue, section: 0)], with: .automatic)
        }
    }
    public func setPlaceName(_ placeName: String) {
        self.placeName = placeName
    }

    private var photo: UIImage? {
        didSet {
            tableView.reloadRows(at: [IndexPath(row: CellIndexes.placeTitleCell.rawValue, section: 0)], with: .automatic)
        }
    }
    public func setPhoto(_ photo: UIImage) {
        self.photo = photo
    }

    private var rating: Int = 0 {
        didSet {
            tableView.reloadRows(at: [IndexPath(row: CellIndexes.ratingCell.rawValue, section: 0)], with: .automatic)
        }
    }
    public func setRating(_ rating: Int) {
        self.rating = rating
    }

    private var comment: String? {
        didSet {
            tableView.reloadRows(at: [IndexPath(row: CellIndexes.commentCell.rawValue, section: 0)], with: .automatic)
        }
    }
    public func setComment(_ comment: String) {
        self.comment = comment
    }
    
    public var viewModel: PlaceViewModelProtocol?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: CellIdentifiers.placeTitleCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.placeTitleCell)
            tableView.register(UINib(nibName: CellIdentifiers.ratingCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.ratingCell)
            tableView.register(UINib(nibName: CellIdentifiers.goToCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.goToCell)
            tableView.register(UINib(nibName: CellIdentifiers.commentCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.commentCell)
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 100
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        viewModel = PlaceViewModel()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.setViewController(self)
        viewModel?.placeModelRequested()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textViewEndEditing(_ :)))
        gestureRecognizer.delegate = self
        self.tableView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func textViewEndEditing(_ recognizer: UITapGestureRecognizer) {
        tableView.endEditing(true)
    }
}

extension PlaceViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension PlaceViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellIndexes.placeTitleCell.rawValue:
            return 250
        case CellIndexes.ratingCell.rawValue,
             CellIndexes.goToCell.rawValue :
            return 50
        default:
            return UITableViewAutomaticDimension
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == CellIndexes.placeTitleCell.rawValue,
            let titleCell = makePlaceTitleCell() {
            return titleCell
        } else if indexPath.row == CellIndexes.ratingCell.rawValue,
            let ratingCell = makeRatingCell() {
            return ratingCell
        } else if indexPath.row == CellIndexes.goToCell.rawValue,
            let menuCell = makeGoToMenuCell() {
            return menuCell
        } else if indexPath.row == CellIndexes.commentCell.rawValue,
            let commentCell = makeCommentCell() {
            return commentCell
        }
        return UITableViewCell()
    }

    private func makePlaceTitleCell() -> PlaceTitleCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.placeTitleCell) as? PlaceTitleCell else {
            return nil
        }

        cell.titleTextField.text = placeName
        cell.titleTextField.isEnabled = isEditable
        cell.titleImageView.image = photo
        return cell
    }

    private func makeRatingCell() -> RatingCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.ratingCell) as? RatingCell else {
            return nil
        }

        return cell
    }

    private func makeGoToMenuCell() -> GoToCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.goToCell) as? GoToCell else {
            return nil
        }

        cell.goToLabel.text = "Menu"
        return cell
    }

    private func makeCommentCell() -> CommentCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.commentCell) as? CommentCell else {
            return nil
        }

        cell.commentTextView.delegate = self
//        cell.commentTextView.isEditable = isEditable
        if let commentText = comment {
            cell.commentTextView.text = commentText
            cell.commentTextView.textColor = UIColor.black
        } else {
            cell.commentTextView.text = "Enter a comment for this Place..."
            cell.commentTextView.textColor = UIColor.lightGray
        }
        return cell
    }
}

extension PlaceViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }

    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter a comment for this Place..."
            textView.textColor = UIColor.lightGray
        }
        viewModel?.updateCommentRequested(textView.text)
    }

    public func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension PlaceViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let _ = touch.view as? UITextView {
            return false
        }
        return true
    }
}
