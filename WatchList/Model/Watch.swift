//
//  Watch.swift
//  WatchList
//
//  Created by Teguh Wibowo Wijaya on 20/02/23.
//

import Foundation

struct Watch: Decodable {
    let id: Int
    let name: String
    let price: Double
//    let date: String
    let description: String
    let category: String
    let imageUrlString: String
    let rating: Rating
    var isLiked: Bool = true
    
    var priceString: String {
        return String(format: "$ %.2f", locale: .autoupdatingCurrent, price)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case price
        case description
        case category
        case imageUrlString = "image"
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(String.self, forKey: .category)
        self.imageUrlString = try container.decode(String.self, forKey: .imageUrlString)
        self.rating = try container.decode(Rating.self, forKey: .rating)
    }
}
