//
//  CPAPresenter.swift
//  CatsPhotosApp
//
//  Created by Yulia on 11.10.2021.
//

import Foundation
import Combine

protocol CPAPresenterDeledate: AnyObject {
    func updateUI()
}

class CPAPresenter {
    
    var numberOfrows: Int {
        return catsList.count + 1
    }
    var lastCell: Int {
        return numberOfrows - 1
    }
    weak var view: CPAPresenterDeledate?
    var catsList: [CPACatsModel] = []
    var networkManager: CPANetworManagerType? = CPANetworkManager()
    
    func fetchData() {
        networkManager?.fetchData() { (cats, error) in

            guard let cats = cats else { return }
            self.catsList += cats
            self.view?.updateUI()
        }
    }
    
    func cellModelForRow(_ row: Int) -> CPACatsModel? {
        guard catsList.indices.contains(row) else { return nil }
        return catsList[row]
    }
}
