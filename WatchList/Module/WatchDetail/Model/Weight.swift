//
//  Weight.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 26/03/23.
//

import Foundation

struct Weight {
    let value: Int
    let type: String
    
    var weightString: String {
        return "\(value) \(type)"
    }
}
