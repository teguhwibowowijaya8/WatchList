//
//  FetchDataService.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 24/03/23.
//

import Foundation

enum FetchDataError: Error {
    case invalidUrl
    case fetchError(errorMessage: String)
    case noData
}

protocol FetchDataProtocol {
    func fetchData(
        with url: String?,
        onCompletion: @escaping (Result<Data, FetchDataError>) -> Void
    )
}

struct FetchDataService: FetchDataProtocol {
    func fetchData(with urlString: String?, onCompletion: @escaping (Result<Data, FetchDataError>) -> Void) {

        guard let urlString = urlString,
                let url = URL(string: urlString)
        else { return onCompletion(.failure(.invalidUrl)) }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return onCompletion(.failure(
                    .fetchError(errorMessage: error.localizedDescription))
                )
            } else if let response = response as? HTTPURLResponse,
                      response.statusCode > 299 {
                return onCompletion(.failure(
                    .fetchError(errorMessage: "Fetch Data error with status code of \(response.statusCode) with description: \(response.description)")
                ))
            }
            
            if let data = data {
                return onCompletion(.success(data))
            }
            
            return onCompletion(.failure(.noData))
        }.resume()
        
    }
    
    static func getErrorMessage(from error: FetchDataError) -> String {
        
        switch error {
        case .noData:
            return "No Data Available."
        case .invalidUrl:
            return "Invalid URL, please set the valid URL."
        case .fetchError(let fetchErrorMessage):
            return fetchErrorMessage
        }
        
    }
}
