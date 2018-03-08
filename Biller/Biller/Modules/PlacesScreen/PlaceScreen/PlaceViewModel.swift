//
//  PlaceViewModel.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 11/4/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import RealmSwift

public protocol PlaceViewControllerProtocol: class {
    func setIsEditable(_ isEditable: Bool)
    func setPlaceName(_ placeName: String)
    func setPhoto(_ photo: UIImage)
    func setRating(_ rating: Int)
    func setComment(_ comment: String)
}

public protocol PlaceViewModelInputProtocol {
    func setPlaceModel(_ place: PlaceModel)
    func setIsPlaceEditable(_ isEditable: Bool)
}

public class PlaceViewModel: PlaceViewModelProtocol, PlaceViewModelInputProtocol {

    public var notificationToken: NotificationToken?

    private var isPlaceEditable: Bool = false
    public func setIsPlaceEditable(_ isEditable: Bool) {
        isPlaceEditable = isEditable
        if let vc = viewController {
            vc.setIsEditable(isPlaceEditable)
        }
    }
    
    private weak var viewController: PlaceViewControllerProtocol?
    public func setViewController(_ viewController: PlaceViewControllerProtocol) {
        self.viewController = viewController
    }

    private var placeModel: PlaceModel?
    public func setPlaceModel(_ place: PlaceModel) {
        placeModel = place
    }

    public func placeModelRequested() {
        observePlace()
    }

    public func updateCommentRequested(_ newCommentText: String) {
        let realm = Realm.getRealm()
        do {
            try realm.write {
                if let place = placeModel, let placeComment = place.comment {
                    placeComment.text = newCommentText
                } else if let place = placeModel {
                    place.comment = CommentModel(type: .place, text: newCommentText)
                }
            }
        } catch {
            if let place = placeModel {
                print("Error while updating comment for Place \(place.id)): \(error)")
            }
        }
    }

    private func setPlaceInitials() {
        if let vc = viewController, let place = placeModel {
            vc.setIsEditable(isPlaceEditable)
            vc.setPlaceName(place.name)
            vc.setRating(place.rating)

            if let comment = place.comment, let commentText = comment.text {
                vc.setComment(commentText)
            }
            if let photoData = place.photo,
                let photo = UIImage(data: photoData as Data) {
                vc.setPhoto(photo)
            }
        }
    }

    private func observePlace() {
        if let place = placeModel {
            setPlaceInitials()
            
            notificationToken = place.observe { [weak self] placeChanges in
                guard let this = self else { return }

                switch placeChanges {
                case .change(let placeChange):
                    if !placeChange.isEmpty, let vc = this.viewController {
                        let p = placeChange[0]
                        switch p.name {
                        case "name":
                            if let name = p.newValue as? String {
                                vc.setPlaceName(name)
                            }
                        case "rating":
                            if let rating = p.newValue as? Int {
                                vc.setRating(rating)
                            }
                        case "photo":
                            if let photoData = p.newValue as? Data,
                                let photo = UIImage(data: photoData) {
                                vc.setPhoto(photo)
                            }
                        case "comment":
                            if let comment = p.newValue as? CommentModel,
                                let commentText = comment.text {
                                vc.setComment(commentText)
                            }
                        default: break
                        }
                    }
                case .error(let error):
                    print("Error during observing the Place model: \(error)")
                default: break
                }
            }
        } else {
            print("No place model found to present")
        }
    }
}
