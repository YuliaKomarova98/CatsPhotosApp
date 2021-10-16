//
//  CPAConstants.swift
//  CatsPhotosApp
//
//  Created by Yulia on 11.10.2021.
//

import Foundation

struct CPAConstants {
    static let url = "https://api.thecatapi.com/v1/images/search?limit=20"
    static let STMCollectionViewCell = "CPACollectionViewCell"
    static let STMFetchCollectionViewCell = "CPAFetchCollectionViewCell"
    static let STMFavoritesCollectionViewCell = "CPAFavoritesCollectionViewCell"
    static let toDetailsViewSegue = "toDetailsView"
    static let toDetalisImageSegue = "toDetalisImage"
    static let imageKey = "image"
    static let imageClass = "Image"
}

struct CPAStrings {
    static let mainScreen = "main_screen".localized
    static let favorites = "favorites".localized
    static let saved = "saved".localized
    static let imageAddedToFavorites = "image_added_to_favorites".localized
    static let saveError = "save_error".localized
    static let imageSavedInPhoto = "image_saved_in_photo".localized
    static let imageDeleted = "image_deleted".localized
    static let savePhoto = "save_photo".localized
    static let addToFavorited = "add_to_favorites".localized
    static let removeFormFavorites = "remove_form_favorites".localized
}
