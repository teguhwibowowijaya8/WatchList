//
//  GetImageService.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 24/03/23.
//

import UIKit

protocol GetImageProtocol {
    func getImage(
        of urlString: String?,
        onCompletion: @escaping (_ image: UIImage?, _ errorMessage: String?) -> Void
    )
}

struct GetImageService: GetImageProtocol {
    private let fetchDataService = FetchDataService()
    
    func getImage(
        of urlString: String?,
        onCompletion: @escaping (UIImage?, String?) -> Void
    ) {
        
        fetchDataService.fetchData(with: urlString) { response in
            switch response {
            case .success(let data):
                return onCompletion(UIImage(data: data), nil)
                
            case .failure(let error):
                let errorMessage = FetchDataService.getErrorMessage(from: error)
                return onCompletion(nil, errorMessage)
            }
        }
    }
    
}
