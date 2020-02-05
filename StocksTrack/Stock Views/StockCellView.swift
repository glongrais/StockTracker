//
//  StockCellView.swift
//  StocksTrack
//
//  Created by Guillaume Longrais on 21/08/2019.
//  Copyright © 2019 Guillaume Longrais. All rights reserved.
//

import SwiftUI

struct StockCellView: View {
    
    @ObservedObject var networkManager: NetworkManager
    var stock: String
    var nbStock: [Double]
    @State var touched = false
    
    var body: some View {
        let stockInfo = self.networkManager.stockList.results.stockInfo
        let keys = Array(stockInfo.keys.sorted())
        var val = [Double](repeating: 0.0, count: stockInfo.count)
        for i in 0 ..< val.count{
            val[i] = Double(stockInfo[keys[i]]!.close)!
        }
        
        var chartSize = CGFloat(30)
        var lineWidth = CGFloat(1.0)
        if(self.touched){
            chartSize = CGFloat(100)
            lineWidth = CGFloat(2.0)
        }
        
        return
            HStack{
                if(!self.touched){
                    Text(self.stock)
                    Spacer()
                    Text(val.count == 0 ? "" : String(val.last!))
                    Spacer()
                }
                VStack{
                    Group {
                        if(stockInfo.count == 0){
                            StockLoadingView()
                        }else{
                            StockChartView(val: val, keys: keys, displayLegend: $touched, lineWidth: lineWidth)
                                .frame(height: chartSize)
                                .onTapGesture {
                                    self.touched.toggle()
                            }
                        }
                    }
                    if(self.touched && self.nbStock[0] != 0){
                        StockHoldingView(lastVal: val.last!, buyPrice: self.nbStock[1], nbStock: self.nbStock[0])
                    }
                }
        }
    }
    
    init(stock: String, nbStock: [Double]) {
        self.stock = stock
        self.nbStock = nbStock
        self.networkManager = NetworkManager(stockSymbol: stock)
    }
}

struct StockCellView_Previews: PreviewProvider {
    static var previews: some View {
        return StockCellView(stock: "ESI.PA", nbStock: [93.0, 28.4])
    }
}
