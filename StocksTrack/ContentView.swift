//
//  ContentView.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 21/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let stocks = ["ESI.PA", "AAPL", "GOOG", "UG.PA"]
    let nbStock = [[93.0, 28.4], [0, 0], [0, 0], [0, 0]]
    var body: some View {
        VStack{
            SearchBarView()
            List{
                ForEach(0 ..< self.stocks.count){ i in
                    StockCellView(stock: self.stocks[i], nbStock: self.nbStock[i])
                }
            }
            .background(Color("backgroundColor"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
