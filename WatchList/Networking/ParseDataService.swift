//
//  ParseDataService.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 24/03/23.
//

import Foundation

protocol ParseDataProtocol {
    func parse<T: Decodable>(
        _ data: Data,
        to: T.Type,
        onCompletion: (Result<T, Error>) -> Void
    )
}

struct ParseDataService: ParseDataProtocol {
    func parse<T>(_ data: Data, to model: T.Type, onCompletion: (Result<T, Error>) -> Void) where T : Decodable {
        
        do {
            let decoder = JSONDecoder()
            let modelData = try decoder.decode(model, from: data)
            onCompletion(.success(modelData))
            
        } catch let error {
            return onCompletion(.failure(error))
        }
        
    }
}
