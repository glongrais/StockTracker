//
//  NetworkManager.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 21/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkManager : ObservableObject {
    var objectWillChange = PassthroughSubject<NetworkManager, Never>()
    
    var stockList = StockAPIList(results: StockListEntry()) {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    init(stockSymbol: String){
        self.parse(stockSymbol: stockSymbol)

        
    }
    
    func parse(stockSymbol: String){
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" + stockSymbol + "&interval=5min&apikey=JO4YMVNMKL30X5MB") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            //TODO : Handle error when loading data
            do{
            let stockList = try JSONDecoder().decode(StockAPIList.self, from: data)
                
                DispatchQueue.main.async {
                    self.stockList = stockList
                }
            } catch{
                sleep(30)
                self.parse(stockSymbol: stockSymbol)
            }
            
        }.resume()
    }
}
