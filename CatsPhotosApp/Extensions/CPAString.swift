//
//  String.swift
//  CatsPhotosApp
//
//  Created by Yulia on 15.10.2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
