//
//  StockSearchJSON.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 22/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import Foundation

struct StockSearchAPI : Decodable {
    var results: [StockSearchEntry]
    
    enum CodingKeys: String, CodingKey{
        case results = "bestMatches"
    }
}

struct StockSearchEntry : Decodable {
    var symbol: String
    var name: String
    var type: String
    var region: String
    var marketOpen: String
    var marketClose: String
    var timezone: String
    var currency: String
    var matchScore: String
    
}
