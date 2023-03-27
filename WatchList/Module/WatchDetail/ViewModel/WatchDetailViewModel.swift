//
//  WatchDetailViewModel.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 24/03/23.
//

import Foundation

protocol WatchDetailProtocol {
    func onGetWatchDetailCompleted()
}

class WatchDetailViewModel {
    var watchDetail: WatchDetails?
    var details: [WatchDetail]?
    var productId: Int
    var delegate: WatchDetailProtocol?
    var errorMessage: String?
    
    private let urlString: String
    private var getAPIService: GetAPIProtocol
    
    init(
        productId: Int,
        getAPIService: GetAPIProtocol = GetAPIService()
    ) {
        self.productId = productId
        self.urlString = "\(Constant.baseUrlString)/\(self.productId)"
        self.getAPIService = getAPIService
    }
    
    func getWatchDetail() {
        self.errorMessage = nil
        self.getAPIService.setUrl(with: urlString)
        getAPIService.getAPI(model: Watch.self) { result, errorMessage in
            if let result = result {
                self.watchDetail = WatchDetails(watch: result)
                self.details = self.watchDetail?.getDetails()
                self.delegate?.onGetWatchDetailCompleted()
            } else if let errorMessage = errorMessage {
                print(errorMessage)
                self.errorMessage = errorMessage
            }
        }
    }
}
