//
//  WatchListViewModel.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 24/03/23.
//

import Foundation

protocol WatchListDelegate {
    func onGetWatchCompleted()
}

class WatchListViewModel {
    private let baseUrl = "https://fakestoreapi.com/products"
    private var getAPIService: GetAPIProtocol
    var watchList: [Watch]?
    private var errorMessage: String?
    
    var delegate: WatchListDelegate?
    
    init(getAPIService: GetAPIProtocol = GetAPIService()) {
        self.getAPIService = getAPIService
        self.getAPIService.setUrl(with: baseUrl)
    }
    
    func getWatchList() {
        errorMessage = nil

        getAPIService.getAPI(model: [Watch].self) { result, errorMessage in
            if let result = result {
                self.watchList = result
                self.delegate?.onGetWatchCompleted()
            } else if let error = errorMessage {
                self.errorMessage = error
                self.delegate?.onGetWatchCompleted()
            }
        }
        
    }
}
