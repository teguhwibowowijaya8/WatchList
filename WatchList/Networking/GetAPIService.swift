//
//  GetAPIService.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 24/03/23.
//

import Foundation

protocol GetAPIProtocol {
    mutating func setUrl(with string: String)
    func getAPI<T: Decodable>(
        model: T.Type,
        onCompletion: @escaping (_ result: T?, _ errorMessage: String?) -> Void
    )
}

struct GetAPIService: GetAPIProtocol {
    private var url: String?
    private let fetchDataService = FetchDataService()
    private let parseDataService = ParseDataService()
    
    mutating func setUrl(with string: String) {
        self.url = string
    }
    
    func getAPI<T>(
        model: T.Type,
        onCompletion: @escaping (T?, String?) -> Void)
    where T : Decodable {

        fetchDataService.fetchData(with: url) { fetchResponse in
            switch fetchResponse {
            case .success(let data):
                self.parseDataService.parse(data, to: model) { decodeResponse in
                    switch decodeResponse {
                    case .success(let decodedData):
                        return onCompletion(decodedData, nil)
                    case .failure(let error):
                        return onCompletion(nil, "Decode error with decription: \(error.localizedDescription)")
                    }
                }
                
                
            case .failure(let error):
                let errorMessage = FetchDataService.getErrorMessage(from: error)
                return onCompletion(nil, errorMessage)
            }
            
        }
        
    }
}
