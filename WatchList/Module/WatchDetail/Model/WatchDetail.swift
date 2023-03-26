//
//  WatchDetail.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 26/03/23.
//

import Foundation

enum WatchDetailEnum: String {
    case stock = "Stock"
    case size = "Size"
    case weight = "Weight"
    case rating = "Rating"
    case ratedBy = "Rated By"
    case descriptionTitle = "Description"
    case descriptionBody = "DescriptionBody"
}

struct WatchDetail {
    let type: WatchDetailEnum
    let value: String
    
    init(type: WatchDetailEnum, value: String? = nil) {
        self.type = type
        self.value = value ?? "-"
    }
}
