//
//  StockCell.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 21/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import Foundation

struct StockAPIList : Decodable{
    var results: StockListEntry
    
    enum CodingKeys: String, CodingKey{
        case results = "Time Series (5min)"
    }
}

struct StockListEntry : Decodable {
    var stockInfo: [String: StockInfo]
    
    struct DetailKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.stringValue = "\(intValue)";
            self.intValue = intValue
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailKey.self)
        
        var stockInfo = [String: StockInfo]()
        for key in container.allKeys {
            if let model = try? container.decode(StockInfo.self, forKey: key) {
                stockInfo[key.stringValue] = model
            }
        }
        
        self.stockInfo = stockInfo
    }
    
    init(stockInfo: [String: StockInfo]? = nil){
        self.stockInfo = [String: StockInfo]()
    }
    
}

struct StockInfo : Decodable {
    var open: String
    var high: String
    var low: String
    var close: String
    var volume: String
    
    enum CodingKeys: String, CodingKey{
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}
