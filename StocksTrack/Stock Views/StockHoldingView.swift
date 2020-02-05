//
//  StockHoldingView.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 03/01/2020.
//  Copyright © 2020 Guillaume Longrais. All rights reserved.
//

import SwiftUI

struct StockHoldingView: View {
    
    var lastVal: Double
    var buyPrice: Double
    var nbStock: Double
    
    var body: some View {
        
        let txt = "Number of Stocks : " + String(self.nbStock) + " Purchase Price : " + String(self.nbStock*self.buyPrice) + " Current Value : " + String(self.nbStock*self.lastVal)
        return Text(txt)
        
    }
}

struct StockHoldingView_Previews: PreviewProvider {
    static var previews: some View {
        StockHoldingView(lastVal: 30, buyPrice: 28, nbStock: 10)
    }

}
