//
//  WatchDetail.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 26/03/23.
//

import Foundation

struct WatchDetails {
    var watch: Watch
    var stock: Int?
    var size: String?
    var weight: Weight?
    
    func getDetails() -> [WatchDetail] {
        return [
            WatchDetail(type: .stock, value: "\(stock ?? 0)"),
            WatchDetail(type: .size, value: size),
            WatchDetail(type: .weight, value: weight?.weightString),
            WatchDetail(type: .rating, value: "\(watch.rating.rate)"),
            WatchDetail(type: .ratedBy, value: "\(watch.rating.count)"),
            WatchDetail(type: .descriptionTitle, value: ""),
            WatchDetail(type: .descriptionBody, value: watch.description)
            
        ]
    }
}
