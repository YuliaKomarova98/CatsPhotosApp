//
//  CPANetworkManager.swift
//  CatsPhotosApp
//
//  Created by Yulia on 11.10.2021.
//

import Foundation
import Combine

protocol CPANetworManagerType {
    var page: Int { get }
    var itemPerPage: Int { get set }
    func loadData(completion: @escaping(_ cats: [CPACatsModel]?, _ error: String?) -> Void)
    func fetchData(completion: @escaping(_ cats: [CPACatsModel]?, _ error: String?) -> Void)
}

extension CPANetworManagerType {
    func loadData(completion: @escaping(_ cats: [CPACatsModel]?, _ error: String?) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=\(itemPerPage)&page=\(page)&order=DESK") else { return }


        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in

            DispatchQueue.main.async {
                guard let data = data else {
                    completion(nil, error.debugDescription)
                    return
                }

                let apiResponse = try! JSONDecoder().decode([CPACatsModel].self, from: data)
                completion(apiResponse, nil)

            }

        }.resume()
    }
}

class CPANetworkManager: CPANetworManagerType {
    func fetchData(completion: @escaping ([CPACatsModel]?, String?) -> Void) {
        page += 1
        loadData(completion: completion)
    }

    private(set) var page: Int = 0

    var itemPerPage: Int = 20
}
